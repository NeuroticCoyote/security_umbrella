 # define the variables here to use
 variable "pools" {
   # curl https://api.linode.com/v4/linode/types
   description = "The Node Pool specifications for the Kubernetes cluster. (required)"

   type = list(object({
     type  = string
     count = number
   }))
   default = [
     {
       type  = "g6-standard-1"
       count = 1 # 20 $ monthly
     }
   ]
 }

 variable "region" {
   # https://registry.terraform.io/providers/linode/linode/latest/docs/resources/lke_cluster#region
   description = "(Required) This Kubernetes cluster's location. (required)"
   type        = string
 }

 variable "tags" {
   type = list(string)
 }

 variable "k8s_version" {
   # https://registry.terraform.io/providers/linode/linode/latest/docs/resources/lke_cluster#k8s_version
   type    = string
   default = "1.21"
 }

 variable "label" {
   type = string
 }