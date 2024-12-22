Utilisateurs
Voici deux utilisateurs pour accéder à l'application :

Login : mrmathieu@gmail.com
Mot de passe : 123456

Login : t@gmail.com
Mot de passe : 123456

Structure du Projet
L'application est structurée comme suit :

Frontend : Développé en Flutter pour une expérience utilisateur fluide et moderne.
Backend : Firebase (pour l'authentification et le stockage des données Firestore).
Intégration IA : Implémentée via TensorFlow Lite et Google Vision API pour la classification d'images.

Intégration d'Intelligence Artificielle
J'ai intégré l'IA en utilisant deux méthodes distinctes :

1. Utilisation d'un modèle entraîné depuis Kaggle
Le modèle utilisé est basé sur MobileNetV2, disponible ici.
https://www.kaggle.com/models/spsayakpaul/mobilenetv2

J'ai tenté d'intégrer ce modèle en utilisant TensorFlow Lite. Les étapes incluaient :

Conversion du modèle pour une utilisation mobile.
Intégration dans ma application Flutter via un service dédié.

Cependant, des problèmes sont survenus :

Étant donné que j'ai majoritairement testé l'application sur Google Chrome, j'ai pas pu vérifier si le modèle fonctionnait correctement.
Lors de la transition vers un émulateur Android pour valider l'intégration, plusieurs erreurs de configuration et de compatibilité sont apparues, et j'ai pas pu les résoudre dans les délais impartis.

2. Utilisation de Google Vision API
Pour surmonter les limitations de TensorFlow, j'ai exploré l'intégration de l'API Google Vision (Vision API) pour la classification d'images.
Les étapes suivantes ont été effectuées :

Configuration d'une clé API sur Google Cloud Platform.
Développement d'un service Flutter pour communiquer avec l'API Vision.
Cependant, en explorant cette option, j'ai réalisé que Vision API est un service payant..., ce qui rendait son utilisation compliquée.

Résultat Final
Après analyse, j'ai décidé de conserver l'intégration TensorFlow Lite comme solution principale, malgré l'absence de validation complète de son fonctionnement.

Les fonctionnalités de base de l'application ont été développées, et l'approche IA a permis une expérience d'apprentissage enrichissante, même si elle reste perfectible.

N'hésitez pas à me contacter pour toute question ou amélioration ! 😊
