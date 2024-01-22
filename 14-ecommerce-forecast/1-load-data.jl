#= 
  feature :

InvoiceNo	A 6-digit integral number uniquely assigned to each transaction. If this code starts with letter 'c' it indicates a cancellation.
StockCode	A 5-digit integral number uniquely assigned to each distinct product.
Description	Product (item) name
Quantity	The quantities of each product (item) per transaction
InvoiceDate	The day and time when each transaction was generated
UnitPrice	Product price per unit in sterling (pound)
CustomerID	A 5-digit integral number uniquely assigned to each customer
Country	The name of the country where each customer resides
=#

include("../utils.jl")

df=load_csv("online_retail")
