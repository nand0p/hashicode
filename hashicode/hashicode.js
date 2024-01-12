module.exports.handler = async (event) => {
  console.log('Event: ', event);
  let resp = '';
  resp += '<!DOCTYPE html><html lang="en">';
  resp += '<head><meta charset="UTF-8">';
  resp += '<meta name="description" content="HashiCorp DevOps Consultants Barcelona.">';
  resp += '<meta name="viewport" content="width=800; initial-scale=0.4">';
  resp += '<meta name="author" content="hashicode.hex7.com">';
  resp += '<meta name="keywords" content="hashicorp, devops, consultant, linux, cloud, terraform">';
  resp += '<meta http-equiv="refresh" content="10">';
  resp += '<meta http-equiv="Accept-Encoding" content="gzip; compress; br">';
  resp += '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">';
  resp += '<title>HashiCODE BCN :: hashicode.hex7.com</title></head>';
  resp += '<body><center><h1>HashiCODE BCN</h1><p><h3>HashiCorp DevOps Consultancy.</h3>';
  resp += '<h3>On-Site Barcelona.</h3>';
  resp += 'Terraform Infrastructure as Code. (DRY Module Support).<p>';
  resp += 'Consul/Nomad Docker Container Clusters. (Faster/Simpler Kubernetes).<p>';
  resp += 'Vault Secrets Engine. (Zero Trust and Secrets Rotation).<p>';
  resp += 'CI/CD Git Pipelines and Branch Theory. (Automate Everything).<p>';
  resp += 'Distributed Deep Learning with Nomad Clusters. (TensorFlow).<p>';
  resp += 'Vagrant Declarative Developer Environments. (Standardized DevEnvs).<p>';
  resp += 'Full Lifecycle Support for all HashiCorp Infrastructure.<p>';
  resp += 'Multi-Cloud Configurations and Disaster Recovery Planning.<p>';
  resp += 'Jira KanBan Scrum Project Management Best Practices.<p>';
  resp += '<h2>CONTACT: HashiCODE at hex7 . com</h2><p><br><p><br><p>';
  resp += 'Site Powered by:';
  resp += '<h5>HashiCorp Terraform<br>AWS Serverless Lambda/APIGateway<br>';
  resp += '<a href=https://github.com/nand0p/hashicode>https://github.com/nand0p/hashicode</a><br>';
  resp += '<a href=https://hashicode.hex7.com>https://hashicode.hex7.com</a><br>';
  resp += '<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>';
  resp += JSON.stringify(event.headers);
  resp += '<br>';
  resp += JSON.stringify(event.multiValueHeaders);
  resp += '<br>';
  resp += JSON.stringify(event.queryStringParameters);
  resp += '<br>';
  resp += JSON.stringify(event.multiValueQueryStringParameters);
  resp += '<br>';

  delete event.requestContext.accountId;
  // SECURITY: dont leak aws account number

  let envVars = process.env;
  let session = envVars.AWS_SESSION_TOKEN;
  session += 'lambda session tokens are ephermeral and not subject to replay attacks';
  resp += 'AWS_SESSION_TOKEN:';
  resp += btoa(session);
  resp += '<br>';
  // SECURITY: obfuscate session token

  delete envVars.AWS_SESSION_TOKEN;
  delete envVars.AWS_ACCESS_KEY_ID;
  delete envVars.AWS_SECRET_ACCESS_KEY;
  // SECURITY dont leak aws access vars

  resp += JSON.stringify(envVars);
  resp += '<br>';
  resp += JSON.stringify(event.requestContext);
  resp += '</body>';


  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'text/html',
      'Product': 'hashicode',
    },
    body: resp,
  }
}
