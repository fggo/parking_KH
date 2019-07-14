package testapi;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Date;
import java.util.Properties;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class TestOpenApi {
	public static void main(String[] args) {
		Properties prop = new Properties();
		String serviceKey = "";
		try {
			prop.load(new FileReader("resources/config.properties"));
			serviceKey = prop.getProperty("serviceKey");
		} catch(IOException e) {
			e.printStackTrace();
		}

		DocumentBuilderFactory dbFactory = null;
		DocumentBuilder dBuilder = null;
		Document doc = null;

		BufferedReader br = null;
		BufferedWriter bw = null;
		Parking p = null;

		try {


//			http://openapi.seoul.go.kr:8088/sample/xml/GetParkInfo/1/5/
			String urlStr = "http://openapi.seoul.go.kr:8088/" +serviceKey+ "/xml/GetParkInfo/1/5/";
			URL url = new URL(urlStr);

			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
//			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));

			dbFactory = DocumentBuilderFactory.newInstance();
			dBuilder = dbFactory.newDocumentBuilder();
			doc = dBuilder.parse(urlconnection.getInputStream());
			
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("row");
			for(int i = 0; i< nList.getLength(); i++) {
				Node nNode = nList.item(i);
				
				System.out.println("\nCurrent Element : " + nNode.getNodeName());
				
				if(nNode.getNodeType() == Node.ELEMENT_NODE) {
					p = new Parking();

					Element eElement = (Element) nNode;
					p.setParkingCode(eElement.getAttribute("PARKING_CODE"));
					p.setParkingName(eElement.getAttribute("PARKING_NAME"));
					p.setAddr(eElement.getAttribute("ADDR"));
					p.setParkingType(eElement.getAttribute("PARKING_TYPE"));
					p.setParkingTypeNm(eElement.getAttribute("PARKING_TYPE_NM"));
					p.setOperationRule(Integer.parseInt(eElement.getAttribute("OPERATION_RULE")));
					p.setOperationRuleNm(eElement.getAttribute("OPERATION_RULE_NM"));
					p.setTel(eElement.getAttribute("TEL"));
					p.setQueStatus(Integer.parseInt(eElement.getAttribute("QUE_STATUS")));
					p.setQueStatusNm(eElement.getAttribute("QUE_STATUS_NM"));
					p.setCapacity(Integer.parseInt(eElement.getAttribute("CAPACITY")));
					p.setCurParking(Integer.parseInt(eElement.getAttribute("CUR_PARKING")));
//					p.setCurParkingTime(eElement.getAttribute("CUR_PARKING_TIME"));
					
					System.out.println(p);
				}
			}
			
			String result = "";
			String line;
			while((line = br.readLine()) != null) {
				result = result + line + "\n";
			}
			System.out.println(result);
			
			bw = new BufferedWriter(new FileWriter("resources/test.xml"));
			bw.write(result);

			
		} catch(IOException e) {
			e.printStackTrace();
		} catch(ParserConfigurationException e) {
			e.printStackTrace();
		} catch(SAXException e) {
			e.printStackTrace();
		} finally {
			try {
				br.close();
				bw.close();
			} catch(IOException e) {
				e.printStackTrace();
			}
		}
			
	}
}
