
#= 
[5. SMS Spam Detection](https://www.datacamp.com/blog/60-python-projects-for-all-levels-expertise)
=#


using CSV, DataFrames, Pipe, JLSO
using MLJ
using TextAnalysis
import MLJ: fit!, transform, predict
df = @pipe CSV.File("./data/spam.csv")|> DataFrame|>dropmissing
coerce!(df, :label => Multiclass)


TfidfTransformer = @load TfidfTransformer pkg = MLJText
tfidf_transformer = TfidfTransformer()
SVC = @load SVC pkg = LIBSVM
model = SVC()
y, X = unpack(df, ==(:label); rng=123)
train, validation = partition(1:length(y), 0.7)


function remove_keys(str)
    sd = StringDocument(str)
    prepare!(sd, strip_articles | strip_stopwords | strip_pronouns | strip_indefinite_articles | strip_numbers | strip_punctuation)
    remove_case!(sd)
    remove_words!(sd, ["--", "a"])
    #stem!(sd)
    return sd

end


function get_tokens(text_data::Vector{String})
    tokens = @pipe text_data |> remove_keys.(_) |> TextAnalysis.text.(_) |> TextAnalysis.tokenize.(_)

    mach = machine(tfidf_transformer, tokens)
    fit!(mach)
    tfidf_mat = MLJ.transform(mach, tokens)
    #return  tfidf_mat
    #JLSO.save("tweet-tfidf-data.jlso",:tfidf_mat => tfidf_mat)
    #@info "succes saved!"
    return tfidf_mat
end

# X_token = get_tokens(X)


# mach = machine(model, X_token, y)
# fit!(mach, rows=train)

size(df)