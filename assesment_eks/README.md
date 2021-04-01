# Terraform

Write a script (in a language of your choice) that does the following:

Take two inputs from the user: Cost of Product Cash Received. Return the change as output. The change should be in the multiples of different and valid denominations of Indian currency. Example Output 1 ❯ python coin_change.py

Please enter the price of product: 430 Please enter the cash received: 500

Please return the following bills to the customer:

Rs. 50      x   1   =   Rs. 50
Rs. 20      x   1   =   Rs. 20
SUM to Return       =   Rs. 70
#################################
1. Use any of your favorite web app ( flask, rails, Django, or whatever else you like )

2. Have three app nodes and Redis for storage.

3. Manage Redis Cluster in a way that it's redis cluster remains highly available and it's data remain persistent in EKS
  
4  Application will be using Redis as a storage.

5. Ability to deploy app locally using Docker compose

6. Ability to Deploy the same app to EKS ( use any automation you like, terraform, cloudformation etc)

7. Out come:

Read me and code on github