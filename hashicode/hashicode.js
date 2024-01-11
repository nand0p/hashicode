module.exports.handler = async (event) => {
  console.log('Event: ', event);
  let resp = '';

  resp += '<center><h1>HashiCODE BCN</h1><p><h3>HashiCorp DevOps Consultancy.</h3><h3>On-Site Barcelona.</h3>';
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
  resp += '<a href=https://github.com/nand0p/hashicode>https://github.com/nand0p/hashicode</a>';
  resp += '<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>.<p><br>';
  resp += JSON.stringify(event.headers);
  resp += JSON.stringify(event.multiValueHeaders);
  resp += JSON.stringify(event.queryStringParameters);
  resp += JSON.stringify(event.multiValueQueryStringParameters);

  // SECURITY: dont leak aws account number
  delete event.requestContext.accountId;
  resp += JSON.stringify(event.requestContext);

  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'text/html',
      'Product': 'hashicode',
    },
    body: resp,
  }
}
