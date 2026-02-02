We have created an API that allows you to shelve the VM when it's not in use. This is to ensure that we keep cost in check when the VM isn't needed!
When you're done using the VM, shelve it by making a request POST https://ovh-shelve-manager.service.gra.prod.consul/instances/shelve/gra5jusaiexpgpu1
When you want to use it again, and you want to unshelve it POST https://ovh-shelve-manager.service.gra.prod.consul/instances/unshelve/gra5jusaiexpgpu1
When you want to check if the VM is shelved or not: GET https://ovh-shelve-manager.service.gra.prod.consul/instances/state/gra5jusaiexpgpu1
