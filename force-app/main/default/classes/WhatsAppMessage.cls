public class WhatsAppMessage{
	@AuraEnabled
	public entry[] entry;
	public class entry {
		@AuraEnabled
		public String id;	//107216392200936
		@AuraEnabled
		public changes[] changes;
	}
	public class changes {
		@AuraEnabled
		public value value;
		@AuraEnabled
		public String field;	//messages
	}
	public class value {
		@AuraEnabled
		public String messaging_product;	//whatsapp
		@AuraEnabled
		public metadata metadata;
		@AuraEnabled
		public contacts[] contacts;
		@AuraEnabled
		public messages[] messages;
	}
	public class metadata {
		@AuraEnabled
		public String display_phone_number;	//15550045176
		@AuraEnabled
		public String phone_number_id;	//111414555108640
	}
	public class contacts {
		@AuraEnabled
		public profile profile;
		@AuraEnabled
		public String wa_id;	//917007691632
	}
	public class profile {
		@AuraEnabled
		public String name;	//Shiva Verma 👋👋
	}
	public class messages {
		@AuraEnabled
		public String fromx;	//917007691632
		@AuraEnabled
		public String id;	//wamid.HBgMOTE3MDA3NjkxNjMyFQIAEhggREU2NjVDRjkzOUU0NDc0QzgzODcwRDFEMkY5MjJDREIA
		@AuraEnabled
		public String timestamp;	//1668083709
		@AuraEnabled
		public String typex;	//image
		@AuraEnabled
		public image image;
		@AuraEnabled
        public text text;
		@AuraEnabled
        public reaction reaction;
		@AuraEnabled
		public context context;
	}
	public class context {
		@AuraEnabled
		public String fromx;	//image/jpeg
		@AuraEnabled
		public String id;	//524901232529895
	}
    public class text{
		@AuraEnabled
        public String body; 
    }
    public class reaction{
		@AuraEnabled
        public String emoji;
		@AuraEnabled
        public String message_id;
    }
    public class image {
		@AuraEnabled
		public String mime_type;	//image/jpeg
		@AuraEnabled
		public String sha256;	//0UCJsOcd5yfWJhrD7hMzkN3JcYxYCs0JSO56paEKy+4=
		@AuraEnabled
		public String id;	//524901232529895
	}
	@AuraEnabled
	public static WhatsAppMessage parse(String json){
		return (WhatsAppMessage) System.JSON.deserialize(json, WhatsAppMessage.class);
	}

}