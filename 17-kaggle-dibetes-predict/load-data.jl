include("../utils.jl")
df=(let
    df=CSV.File("../data/diabetes_prediction_dataset.csv")|>DataFrame 
    describe(df)

#= 
9×7 DataFrame
 Row │ variable             mean     min      median  max          nmissing  eltype   
     │ Symbol               Union…   Any      Union…  Any          Int64     DataType 
─────┼────────────────────────────────────────────────────────────────────────────────
   1 │ gender                        Female           Other               0  String7
   2 │ age                  41.8859  0.08     43.0    80.0                0  Float64
   3 │ hypertension         0.07485  0        0.0     1                   0  Int64
   4 │ heart_disease        0.03942  0        0.0     1                   0  Int64
   5 │ smoking_history               No Info          not current         0  String15
   6 │ bmi                  27.3208  10.01    27.32   95.69               0  Float64
   7 │ HbA1c_level          5.52751  3.5      5.8     9.0                 0  Float64
   8 │ blood_glucose_level  138.058  80       140.0   300                 0  Int64
   9 │ diabetes             0.085    0        0.0     1                   0  Int64
=#

schema(df)
#= 
┌─────────────────────┬────────────┬──────────┐
│ names               │ scitypes   │ types    │
├─────────────────────┼────────────┼──────────┤
│ gender              │ Textual    │ String7  │
│ age                 │ Continuous │ Float64  │
│ hypertension        │ Count      │ Int64    │
│ heart_disease       │ Count      │ Int64    │
│ smoking_history     │ Textual    │ String15 │
│ bmi                 │ Continuous │ Float64  │
│ HbA1c_level         │ Continuous │ Float64  │
│ blood_glucose_level │ Count      │ Int64    │
│ diabetes            │ Count      │ Int64    │
└─────────────────────┴────────────┴──────────┘
=#


df_fixed = coerce(df, :gender=>Multiclass,
                   :smoking_history=>Multiclass,
                   )
schema(df_fixed).scitypes
return df_fixed
end)

