package testapi;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Properties;

import org.json.JSONArray;
import org.json.JSONObject;

public class ParseJSON2 {
	public static void main(String[] args) {

		Properties prop = new Properties();
		try {
			prop.load(new FileReader("resources/config.properties"));
		} catch(IOException e) {
			e.printStackTrace();
		}
		String serviceKey = prop.getProperty("serviceKey2");

		String ckanResceId = "prkplce-info-std";

		//case 1
		String city = "서울특별시";
		String temp = "%20";
		String district = "강남구";

		String instt_nm = city+temp+district;

		//case 2
//		B553774	서울시설공단
//		B553766	서울교통공사
//		B552067	서울특별시중구시설관리공단
//		B551897	서울특별시성동구도시관리공단
//		B551282	강북구도시관리공단
		instt_nm = "서울특별시성동구도시관리공단";


//		KOR -> UTF-8 변환
//		byte[] byteArr = instt_nm.getBytes(StandardCharsets.UTF_8);
//		ByteBuffer byteBuffer = StandardCharsets.UTF_8.encode(instt_nm);
//		instt_nm = new String(byteArr, StandardCharsets.UTF_8);

		String urlStr = "http://api.data.go.kr/openapi/";
		urlStr += ckanResceId;
		urlStr += "?serviceKey=" + serviceKey;
		urlStr += "&type=json";
//		urlStr += "&s_page=0";
//		urlStr += "&s_list=1";
		urlStr += "&instt_nm=" + instt_nm;
//		3030000	서울특별시 성동구
//		3040000	서울특별시 광진구
//		3060000	서울특별시 중랑구
//		3070000	서울특별시 성북구
//		3080000	서울특별시 강북구
//		3110000	서울특별시 은평구
//		3140000	서울특별시 양천구
//		3150000	서울특별시 강서구
//		3160000	서울특별시 구로구
//		3170000	서울특별시 금천구
//		3180000	서울특별시 영등포구
//		3190000	서울특별시 동작구
//		3200000	서울특별시 관악구
//		3210000	서울특별시 서초구
//		3220000	서울특별시 강남구
//		3230000	서울특별시 송파구
//		3240000	서울특별시 강동구
//		B553774	서울시설공단(노원구 도봉구 동대문구 마포구 서대문구 용산구 [위에 없는주소] +
//		                  강남구 강동구 강북구 강서구 관악구 광진구 구로구 금천구 동작구 서초구 성동구 
//		                  송파구 양천구 영등포구 은평구 종로구 중구)
//		B553766	서울교통공사 (서초구 성동구)
//		B552067	서울특별시중구시설관리공단 (중구)
//		B551897	서울특별시성동구도시관리공단 (성동구)
//		B551282	강북구도시관리공단 (강북구)

		BufferedReader br = null;
		try {
			URL url = new URL(urlStr);
			URLConnection urlConnection = url.openConnection();
			HttpURLConnection connection = null;
			if(urlConnection instanceof HttpURLConnection)
			{
				connection = (HttpURLConnection) urlConnection;
			}
			else
			{
				System.out.println("error");
				return;
			}
			br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
			String result = "";
			String line;
			while((line = br.readLine()) != null)
			{
				result += line+"\n";
			}
			System.out.println(result);

			JSONObject obj = new JSONObject(result);
			JSONArray arr = obj.getJSONObject("response").getJSONObject("body").getJSONArray("items");
//			Parking p = null;

			System.out.println("Parsing List Num # = " + arr.length());
//
//			for(int i =0; i<arr.length(); i++) {
//				p = new Parking();
//
//				p.setParkingCode(arr.getJSONObject(i).getString("PARKING_CODE"));
//				p.setParkingName(arr.getJSONObject(i).getString("PARKING_NAME"));
//				p.setAddr(arr.getJSONObject(i).getString("ADDR"));
//				p.setParkingType(arr.getJSONObject(i).getString("PARKING_TYPE"));
//				p.setParkingTypeNm(arr.getJSONObject(i).getString("PARKING_TYPE_NM"));
//				p.setOperationRule(arr.getJSONObject(i).getInt("OPERATION_RULE"));
//				p.setOperationRuleNm(arr.getJSONObject(i).getString("OPERATION_RULE_NM"));
//				p.setTel(arr.getJSONObject(i).getString("TEL"));
//				p.setQueStatus(arr.getJSONObject(i).getInt("QUE_STATUS"));
//				p.setQueStatusNm(arr.getJSONObject(i).getString("QUE_STATUS_NM"));
//				p.setCapacity(arr.getJSONObject(i).getInt("CAPACITY"));
//				p.setCurParking(arr.getJSONObject(i).getInt("CUR_PARKING"));
//				
//				System.out.println(p);
//			}
		} catch(IOException e) {
			e.printStackTrace();
		} finally {
			try {
				br.close();
			} catch(IOException e) {
				e.printStackTrace();
			}
		}
	}
}
