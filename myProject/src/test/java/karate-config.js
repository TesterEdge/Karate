function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    articleapi: 'https://conduit-api.bondaracademy.com/api/articles'
  
  }
  if (env == 'dev') {
    config.username = 'kara101@test.com';
    config.userpassword = 'kara101'
  }
  if (env == 'QA') 
    {
    config.username = 'penny@bbt.com';
    config.userpassword = 'abc1234'
  }
  var authtoken = karate.callSingle ('classpath:Helpers/createToken.feature',config).token1
  karate.configure('headers',{Authorization : 'Token '+ authtoken})  
  return config;
}