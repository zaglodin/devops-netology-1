locals {
    instance_count = {
        stage = 1
        prod  = 2
    }
    instance_type  = {
        stage = "t2.micro"
        prod  = "t3.micro"
    }
    instance_stage = {
        main = "t2.micro"
    }
    instance_prod = {
        main = "t3.micro"
        mirror = "t3.micro"
    }
}