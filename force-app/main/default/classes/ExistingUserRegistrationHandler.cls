global class ExistingUserRegistrationHandler implements Auth.RegistrationHandler{

global User createUser(Id portalId, Auth.UserData data){

    User u = new User();

 Profile p = [SELECT Id FROM profile WHERE name='System Administrator'];

    u.username = data.email.substring(0,data.email.indexof('@'));

    System.debug('the username is'+ u.username);

    u.email = data.email;

    u.lastName = data.lastName;

    u.firstName = data.firstName;

    u.alias = 'smaru';

    u.languagelocalekey = data.attributeMap.get('language');

    u.localesidkey = 'en_US';

    u.emailEncodingKey = 'UTF-8';

    u.timeZoneSidKey = 'America/Los_Angeles';

    u.profileId = p.Id;

    return u;

}




global void updateUser(Id userId, Id portalId, Auth.UserData data){

    User u = new User(id=userId);

    u.username = 'xyz@gmail.com';

    u.email = 'xyz@gmail.com';

    u.lastName = data.lastName;

    u.firstName = data.firstName;

    u.alias = 'smaru';

    u.languagelocalekey ='en_US';

    u.localesidkey = 'en_US';

    update(u);

}

}