**PLEASE MAKE SURE [DOCKER](https://docs.docker.com/installation/#installation) IS INSTALLED!**

Welcome! This is the Pnd repository. Below you can find some information 
about the folder structure.

* **assets:**         contains all the website assets such as images, javascript, styles

* **lib:**         		contains all lib extensions, utilities, orms, etc

* **routes:**         contains all express routes

* **node_modules:**   contains all standard node modules use by our node.js apps This is 
                      populated via the package.json file.

* **scripts:**        contains some very handy shell scripts for things like (re)deploying docker
                
* **views:**          contains all EJS views for rendering dynamic pages


Pnd can be deployed using docker both locally and to aws. When deploying
locally you can create both development *(port 1337)* & production *(port 80)* containers. 
On aws the environment is set to production. 

* Deploying locally `bash scripts/local.deploy.sh [dev | prod]`

* Deploying on docker `bash scripts/docker.deploy.sh [dev | prod | both]`

* Redeploying on docker `bash scripts/docker.redeploy.sh [dev | prod | both]`

* Deploying on AWS `bash scripts/aws.redeploy.sh`
