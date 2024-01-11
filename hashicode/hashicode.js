module.exports.handler = async (event) => {
  console.log('Event: ', event);
  let resp = '';

  resp += '<center><h1>HashiCODE BCN</h1><p><h3>HashiCorp DevOps Consultancy.</h3><h3>On-Site Barcelona.</h3>';
  resp += 'Terraform Infrastructure as Code. (DRY Module Support).<p>';
  resp += 'Consul/Nomad Docker Container Clusters. (Faster/Simpler Kubernetes).<p>';
  resp += 'CI/CD Git Pipelines and Branch Theory. (Automate Everything).<p>';
  resp += 'Distributed Deep Learning with Nomad Clusters. (TensorFlow).<p>';
  resp += 'Full Lifecycle Support for all HashiCorp Infrastructure.<p>';
  resp += 'Jira KanBan Scrum Project Management Best Practices.<p>';
  resp += '<h2>CONTACT: HashiCODE at hex7 . com</h2><p><br><p><br><p>';
  resp += 'Site Powered by:';
  resp += '<h5>HashiCorp Terraform<br>AWS Serverless Lambda/APIGateway<br>';
  resp += '<a href=https://github.com/nand0p/hashicode>https://github.com/nand0p/hashicode</a><p><br><p>';
  resp += JSON.stringify(event.headers);

  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'text/html',
      'Product': 'hashicode',
    },
    body: resp,
  }
}
