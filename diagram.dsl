workspace {

    model {


        user_segmento = person "Usuario que desea reciclar" "" 
        user = person "Empresarios sector reciclaje" "Centros de reciclaje" "RecycleCenter"
       
        mobileApp = softwareSystem "Mobile Application"{
           landingPage = container "Landing page" "" "" "Landing" {
               user_segmento -> this "Accede"
               user -> this "Accede"
           }
           app = container "Mobile Application" "" "" "Mobile" {
                landingPage -> this "Direcciona"
            }
            
            Perfil = container "Perfil" "Bounded context relacionado con la creación y asociación de cuentas" "BoundedContext" "BoundedContext" {
                app -> this "Registra usuarios según su rol"
            }
            Notificacion = container "Notificación" "Bounded Context relacionado con las notificaciones fuera de la aplicación" "BoundedContext" "BoundedContext" {
                Perfil -> this "Notifica acciones de la cuenta realizadas por el usuario"
            }
            Resenha = container "Reseña" "" "BoundedContext" "BoundedContext" {
                app -> this "Califica el centro de reciclaje"
                this -> Notificacion "Envia confirmación de calificación"
            }
            RCManager = container "Recycle center manager" "Bounded context usado para administrar el centro de reciclaje" "BoundedContext" "BoundedContext" {
                app -> this "Administra el centro de reciclaje con "
            }
            Ruta = container "Ruta" "Ruta" "BoundedContext" "BoundedContext"  {
                app -> this "Visualiza la ruta de seguimiento al cliente al punto de reciclaje"
                this -> Notificacion "Avisa al centro de reciclaje"
            }
            
        }
         database = softwareSystem "Base de datos" "Base de datos" "Database" {
                Perfil -> this "Guarda la información de los perfiles"
                RCManager -> this "Usa"
                Ruta -> this "Usa"
                Resenha -> this "Usa"
                Notificacion -> this "Guarda historial de notificaciones"
        }
        
        
        crmSytem = softwareSystem "CRM" {
            mobileApp -> this "Retrieve user profile"
            

        }
        LocationSystem = softwareSystem "Sistema de ubicación" "" "Ubicacion" {
            Ruta -> this "Recibe información de GPS"
        }
        EmailSystem = softwareSystem "Sistema de correos" "" "Correos" {
            notificacion -> this "Envia correos usando"
            
            this -> user_segmento "Envia correo a"
            this -> user "Envia correo a"
        
        }
    }

    views {
        theme default
        systemContext mobileApp {
            include *
            autolayout lr
        }
        container  mobileApp {
            include *
            autolayout lr
        }
      
        
        
        styles {
            element "Database" {
                shape Cylinder
                background #31943b
                icon https://cdn-icons-png.flaticon.com/512/7835/7835690.png

            }
            element "BoundedContext" {
                color #000000
                background #de5735
                fontSize 30
            }
            element "Landing" {
                shape WebBrowser
                background #80ed99
                icon https://cdn-icons-png.flaticon.com/512/3094/3094384.png
            }
            element "Mobile" {
                shape MobileDevicePortrait
                background #57cc99
                icon https://cdn-icons-png.flaticon.com/512/5608/5608615.png
            }
            element "Ubicacion" {
                shape Ellipse
                background #005f73
            }
            element "Correos" {
                background #005f73
                shape Ellipse
            }
            element "Person" {
                background #3d405b
            }
            
        }
        
    }

}