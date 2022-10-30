workspace {

    model {


        user_segmento = person "Usuario que desea reciclar"
        user = person "Empresarios sector reciclaje"
        mobileApp = softwareSystem "Mobile Application"{
           app = container "Mobile Application" {
                user_segmento -> this "Access to"
                user -> this "Access to"
            }
            
            businessLogic = container "Business Logic"{
                app -> this "Exposes functionalities"
                dataMapper = component "Data Mapper"
               
              
                
                backend = component "Mobile Application Backend" {
                    app -> this "Expose funcionalities"
                   
                    
                }
                
                tracking = component "Tracking component"{
                    backend -> this "Sends information to"
        
                }
                
                signIn = component "Sign in Controller"{
                    app -> this "Uses"
                }

            }
            apiApp = container "API Application" {
                app -> this "Uses"
                
            }
            
            
            DataBase = container "Data Base" "Data base with all the information of recycle points and users"{
           
               dataMapper -> this "Uses"
                apiApp -> DataBase "Reads and writes to"
                tracking -> DataBase "Reads and writes information to"
                signIn -> this "Uses"
            }
        }
        
        crmSytem = softwareSystem "CRM" {
            mobileApp -> this "Retrieve user profile"
            

        }
        
        EmailSystem = softwareSystem "Email System" {
            mobileApp -> this "Send emails using "
            businessLogic -> this "Send emails"
            this -> user_segmento "Sends email to"
            this -> user "Sends email to"
        
        }
    }

    views {
        
        systemContext mobileApp {
            include *
            autolayout lr
        }
        container  mobileApp {
            include *
            autolayout lr
        }
      
        component businesslogic {
            include *
            autolayout lr
        }
        theme default
        
    }

}