import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.URI;


import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Result;
import org.apache.avalon.framework.configuration.DefaultConfigurationBuilder;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.FopFactoryBuilder;
import org.apache.fop.apps.MimeConstants;
import org.jsoup.Jsoup;
import org.jsoup.helper.W3CDom;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Entities.EscapeMode;
import org.w3c.tidy.Tidy;
import org.xml.sax.SAXException;

import com.lowagie.text.html.simpleparser.HTMLWorker;
import com.lowagie.text.pdf.PdfWriter;

public class TestFile {

	public static void main(String[] args) throws Exception {
		 
		Document doc = Jsoup.parse(new File("/Users/raj/workspace_code/test-ws/a-fop-test/src/main/resources/config/hello.html"), "UTF-8");
		
////		Document doc = Jsoup.connect("https://en.wikipedia.org/").get();

		 
		OutputStream out = new BufferedOutputStream(new FileOutputStream(new File("/Users/raj/workspace_code/test-ws/a-fop-test/src/main/resources/output/hello.pdf")));
		doc.outputSettings().syntax(Document.OutputSettings.Syntax.xml);
		
		
		    
		
//		doc.outputSettings().escapeMode(EscapeMode.xhtml);
	    doc.outputSettings().charset("UTF-8");
	    String document = doc.toString();
//	    
	    W3CDom dom = new W3CDom();
	    com.lowagie.text.Document realDOC = new com.lowagie.text.Document();
	    
//	    org.w3c.dom.Document realDoc = dom.fromJsoup(Jsoup.parse(document));
	    PdfWriter.getInstance(realDOC, out);
	    realDOC.open();
	    HTMLWorker htmlWorker = new HTMLWorker(realDOC);
	    htmlWorker.parse(new StringReader(document));
	    realDOC.close();
	    
////		System.out.println(document);
//		
//
//
//		FopFactory fopFactory = FopFactory.newInstance(new File("/Users/raj/workspace_code/test-ws/a-fop-test/src/main/resources/config/pdf/fop.xconf"));
//		OutputStream out = new BufferedOutputStream(new FileOutputStream(new File("/Users/raj/workspace_code/test-ws/a-fop-test/src/main/resources/output/hello.pdf")));
//		
//		try {
//			
//			org.w3c.dom.Document fodoc = xml2FO(realDoc, "/Users/raj/workspace_code/test-ws/a-fop-test/src/main/resources/config/pdf/html.xsl");
//			
//
//				System.out.println(fodoc);
//				
//			    // Step 3: Construct fop with desired output format
//			    Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, out);
//			    
//			    DOMSource source = new DOMSource(fodoc);
//			    
//			    // Step 4: Setup JAXP using identity transformer
//			    TransformerFactory factory = TransformerFactory.newInstance();
//			    Transformer transformer = factory.newTransformer(); // identity transformer
//
//			    // Step 5: Setup input and output for XSLT transformation
//			    // Setup input stream
////			    Source src = new StreamSource(new File("/Users/raj/workspace_code/test-ws/a-fop-test/src/main/resources/config/pdf/m.fo"));
//
//			    // Resulting SAX events (the generated FO) must be piped through to FOP
//			    Result res = new SAXResult(fop.getDefaultHandler());
//
//			    // Step 6: Start XSLT transformation and FOP processing
//			    transformer.transform(source, res);
//
//			} finally {
//			    //Clean-up
//			    out.close();
//			}

		

		

	}
	
	private static  org.w3c.dom.Document xml2FO(org.w3c.dom.Document xml,String styleSheet) throws Exception {
		DOMSource xmlDomSource = new DOMSource(xml);
		DOMResult domResult = new DOMResult();
		Transformer transformer = getTransformer(styleSheet);
		transformer.transform(xmlDomSource, domResult);
		return (org.w3c.dom.Document) domResult.getNode();
		
		
	}

	private static Transformer getTransformer(String styleSheet) throws Exception {
		try {
		TransformerFactory tFactory = TransformerFactory.newInstance();
		DocumentBuilderFactory dFactory = DocumentBuilderFactory.newInstance();
		dFactory.setNamespaceAware(true);
		DocumentBuilder dBuilder;
			dBuilder = dFactory.newDocumentBuilder();
			org.w3c.dom.Document xslDoc = dBuilder.parse(new File(styleSheet));
			
			DOMSource xslDomSource = new DOMSource(xslDoc);
			return tFactory.newTransformer(xslDomSource);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw e;
		}
		
	}

}
