## 1. import package
include("../utils.jl")  

## 2. import data  fixed sciencetype
include("load-data.jl")

@show first(df,5)

using Imbalance

SMOTENC = @load SMOTENC pkg=Imbalance verbosity=0
TomekUndersampler = @load TomekUndersampler pkg=Imbalance verbosity=0
LogisticClassifier = @load LogisticClassifier pkg=MLJLinearModels verbosity=0
