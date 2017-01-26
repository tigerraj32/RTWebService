import Foundation
import AEXML

var str = "Hello, playground"

let node1 = AEXMLElement(name: "cat:calltype", value: "group", attributes: [:])
let node2 = AEXMLElement(name: "cat:code", value: "concept", attributes: [:])


let soap = AEXMLDocument()
let envelope = soap.addChild(name: "soapenv:Envelope",
                             attributes: ["xmlns:soapenv":"http://schemas.xmlsoap.org/soap/envelope/",
                                          "xmlns:cat":"NS1/pcacsoap"])

let header = envelope.addChild(name: "soapenv:Header")
let body = envelope.addChild(name: "soapenv:Body")
let catInfo = body.addChild(name: "cat:sendcataloginfo")
let request = catInfo.addChild(name: "cat:request")
let ttrequest = request.addChild(name: "cat:ttrequest")
ttrequest.addChild(node1)
ttrequest.addChild(node2)



/*
let body = envelope.addChild(name: "soapenv:Body")
body.addChild(AEXMLElement(name: "cat:sendcataloginfo"))
    .addChild(AEXMLElement(name: "cat:request"))
    .addChild(AEXMLElement(name: "cat:ttrequest"))




envelope.addChild(body)
*/


print(soap.xml)


/*
// create XML Document
let soapRequest = AEXMLDocument()
let attributes = ["xmlns:xsi" : "http://www.w3.org/2001/XMLSchema-instance", "xmlns:xsd" : "http://www.w3.org/2001/XMLSchema"]
let envelope = soapRequest.addChild(name: "soap:Envelope", attributes: attributes)

let header = envelope.addChild(name: "soap:Header")
let body = envelope.addChild(name: "soap:Body")
header.addChild(name: "m:Trans", value: "234", attributes: ["xmlns:m" : "http://www.w3schools.com/transaction/", "soap:mustUnderstand" : "1"])
let getStockPrice = body.addChild(name: "m:GetStockPrice")
getStockPrice.addChild(name: "m:StockName", value: "AAPL")

// prints the same XML structure as original
print(soapRequest.xml)
*/