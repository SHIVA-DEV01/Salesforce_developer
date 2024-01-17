public with sharing class WeatherReportWrapper {
	public cls_location[] location;
	public cls_current[] current;
	public class cls_location {
		public String name;	//London
		public String region;	//City of London, Greater London
		public String country;	//United Kingdom
		public Double lat;	//51.52
		public Double lon;	//-0.11
		public String tz_id;	//Europe/London
		public Integer localtime_epoch;	//1685515221
		public String localtime;	//2023-05-31 7:40
	}
	public class cls_current {
		public Integer last_updated_epoch;	//1685514600
		public String last_updated;	//2023-05-31 07:30
		public Integer temp_c;	//11
		public Double temp_f;	//51.8
		public Integer is_day;	//1
		public cls_condition[] condition;
		public Double wind_mph;	//11.9
		public Double wind_kph;	//19.1
		public Integer wind_degree;	//60
		public String wind_dir;	//ENE
		public Integer pressure_mb;	//1028
		public Double pressure_in;	//30.36
		public Integer precip_mm;	//0
		public Integer precip_in;	//0
		public Integer humidity;	//82
		public Integer cloud;	//75
		public Double feelslike_c;	//8.9
		public Integer feelslike_f;	//48
		public Integer vis_km;	//10
		public Integer vis_miles;	//6
		public Integer uv;	//3
		public Double gust_mph;	//13.6
		public Integer gust_kph;	//22
	}
	public class cls_condition {
		public String text;	//Light rain
		public String icon;	////cdn.weatherapi.com/weather/64x64/day/296.png
		public Integer code;	//1183
	}
	public static WeatherReportWrapper parse(String json){
		return (WeatherReportWrapper) System.JSON.deserialize(json, WeatherReportWrapper.class);
	}
}