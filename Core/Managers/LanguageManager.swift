import SwiftUI

class LanguageManager: ObservableObject {
    @AppStorage("selectedLanguage") var selectedLanguage: String = "English"
    
    // Simple dictionary for demonstration purposes
    private let translations: [String: [String: String]] = [
        "English": [
            "GenCare Assist": "GenCare Assist",
            "Home": "Home",
            "Insights": "Insights",
            "History": "History",
            "Profile": "Profile",
            "Overall Health Score": "Overall Health Score",
            "Your current health score is based on your risk factors and lifestyle data.": "Your current health score is based on your risk factors and lifestyle data.",
            "View Details": "View Details",
            "Top Risk Areas": "Top Risk Areas",
            "Recent Insights": "Recent Insights",
            "Sign Out of Account": "Sign Out of Account",
            "Account & Settings": "Account & Settings",
            "Health Management": "Health Management",
            "My Health Data": "My Health Data",
            "Edit Health Info": "Edit Health Info",
            "Security & Settings": "Security & Settings",
            "Help & Support": "Help & Support"
        ],
        "Spanish": [
            "GenCare Assist": "GenCare Asistente",
            "Home": "Inicio",
            "Insights": "Perspectivas",
            "History": "Historial",
            "Profile": "Perfil",
            "Overall Health Score": "Puntuación General de Salud",
            "Your current health score is based on your risk factors and lifestyle data.": "Su puntuación de salud actual se basa en sus factores de riesgo y datos de estilo de vida.",
            "View Details": "Ver Detalles",
            "Top Risk Areas": "Áreas de Riesgo Principal",
            "Recent Insights": "Perspectivas Recientes",
            "Sign Out of Account": "Cerrar Sesión",
            "Account & Settings": "Cuenta y Configuración",
            "Health Management": "Gestión de Salud",
            "My Health Data": "Mis Datos de Salud",
            "Edit Health Info": "Editar Info de Salud",
            "Security & Settings": "Seguridad y Configuración",
            "Help & Support": "Ayuda y Soporte"
        ],
        "French": [
            "GenCare Assist": "GenCare Assistance",
            "Home": "Accueil",
            "Insights": "Aperçus",
            "History": "Historique",
            "Profile": "Profil",
            "Overall Health Score": "Score de Santé Global",
            "Your current health score is based on your risk factors and lifestyle data.": "Votre score de santé actuel est basé sur vos facteurs de risque et vos données de mode de vie.",
            "View Details": "Voir les Détails",
            "Top Risk Areas": "Principaux Risques",
            "Recent Insights": "Aperçus Récents",
            "Sign Out of Account": "Se Déconnecter",
            "Account & Settings": "Compte et Paramètres",
            "Health Management": "Gestion de la Santé",
            "My Health Data": "Mes Données Santé",
            "Edit Health Info": "Modifier Info Santé",
            "Security & Settings": "Sécurité et Paramètres",
            "Help & Support": "Aide et Support"
        ],
         "Hindi": [
            "GenCare Assist": "GenCare सहायता",
            "Home": "होम",
            "Insights": "अंतर्दृष्टि",
            "History": "इतिहास",
            "Profile": "प्रोफ़ाइल",
            "Overall Health Score": "समग्र स्वास्थ्य स्कोर",
            "Your current health score is based on your risk factors and lifestyle data.": "आपका वर्तमान स्वास्थ्य स्कोर आपके जोखिम कारकों और जीवनशैली डेटा पर आधारित है।",
            "View Details": "विवरण देखें",
            "Top Risk Areas": "शीर्ष जोखिम क्षेत्र",
            "Recent Insights": "हालिया अंतर्दृष्टि",
            "Sign Out of Account": "खाते से साइन आउट करें",
            "Account & Settings": "खाता और सेटिंग्स",
            "Health Management": "स्वास्थ्य प्रबंधन",
            "My Health Data": "मेरा स्वास्थ्य डेटा",
            "Edit Health Info": "स्वास्थ्य जानकारी संपादित करें",
            "Security & Settings": "सुरक्षा और सेटिंग्स",
            "Help & Support": "मदद और समर्थन"
        ]
        // Add other languages as needed...
    ]
    
    func setLanguage(_ language: String) {
        selectedLanguage = language
    }
    
    func localizedString(_ key: String) -> String {
        // Fallback to English if language or key is missing
        if let languageDict = translations[selectedLanguage], let value = languageDict[key] {
            return value
        }
        return key
    }
}