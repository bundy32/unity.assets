Shader "z/test"{
    Properties{
        
        _MaskText("Mask texture",2D)="black"{}
        _EmmisionMaskText("EmmisionMask texture",2D)="black"{}
        _MainText("Main texture",2D)="white"{}
        _MainText1("Main texture 1",2D)="white"{}
        _MainText2("Main texture 2",2D)="white"{}

        _EmmisionColor("Emission color",Color)=(1,1,1,1)
        _VectorParm("Vector Param",Vector)=(1.0,0.5,1.0,0.0)


    }

    SubShader{

        CGPROGRAM

        #pragma surface surf Lambert

        sampler2D 
        _MainText,
        _MainText1,
        _MainText2,
        _MaskText,
        _EmmisionMaskText;
        

        fixed3 _EmmisionColor;

        struct Input{
          half2  uv_MainText;
          half2  uv_MaskText;

        };

        void surf(Input IN,inout SurfaceOutput o){

            fixed3 masks=tex2D(_MaskText,IN.uv_MaskText);
            fixed3 clr=tex2D(_MainText,IN.uv_MainText)*masks.r;
            clr+=tex2D(_MainText1,IN.uv_MainText)*masks.g;
            clr+=tex2D(_MainText2,IN.uv_MainText)*masks.b;
            o.Albedo=clr;
            fixed3 emTex=tex2D(_EmmisionMaskText,IN.uv_MainText).rgb;
            o.Emission=emTex.g*_EmmisionColor;

        }

        ENDCG
    }

    Fallback "Diffuse"

}