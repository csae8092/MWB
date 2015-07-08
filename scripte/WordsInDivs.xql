xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html";
declare option output:media-type "text/html";

 <table> 
     <tr>
         <td>div @xml:id</td>
       <!-- <td>Wörter</td> -->
         <td>types</td>
         <td>tokens</td>
         <td>ttr</td>
    </tr>
     {
    for $div in collection("/db/files/millinger1/xml")//tei:text//tei:div
    let $divName := data($div/@xml:id)
    let $words := fn:tokenize(lower-case($div), '\W+')
    let $uniquewords := fn:distinct-values($words)
    let $uniquewordscount :=count($uniquewords)
    let $wordcount :=count($words)
    let $ttr := $uniquewordscount div $wordcount
    order by $wordcount descending 
       return
       <tr>
            <td>{$divName}</td>
            <td>{$uniquewordscount}</td>
            <td>{$wordcount}</td>
            <td>{$ttr}</td> 
       </tr>
     }
</table>