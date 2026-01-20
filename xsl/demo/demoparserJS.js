var fxml=fetch('./Facture3.xml').then(r=>r.text())
var fxsl=fetch('./toHTML.xslt').then(r=>r.text())

Promise.all([fxsl,fxml]).then(arr=>{

    var domparser=new DOMParser();
    var xslDoc=domparser.parseFromString(arr[0],'text/xml');
    var xmlDoc=domparser.parseFromString(arr[1],'text/xml');

    var xsltProc=new XSLTProcessor();
    xsltProc.importStylesheet(xslDoc);
    
    var result=xsltProc.transformToDocument(xmlDoc);
    console.log(result);
    
    document.querySelector('body').appendChild(result.body);

})