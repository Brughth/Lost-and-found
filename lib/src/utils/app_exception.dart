String appAuthException({required String codeerror}) {
  switch (codeerror) {
    case "email-already-exists":
      return "L'adresse email fourni est déjà utilisé par un utilisateur existant. Chaque utilisateur doit avoir un email unique";

    case "id-token-expired":
      return "Le jeton d'identification Firebase fourni a expiré.";

    case "internal-error":
      return "Le serveur d'authentification a rencontré une erreur inattendue lors de la tentative de traitement de la demande.";

    case "invalid-password":
      return "La valeur fournie pour le password de password propriété utilisateur est invalide. Il doit s'agir d'une chaîne d'au moins six caractères.";

    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many requests. Try again later.";

    case "user-not-found":
      return "Il n'existe aucun enregistrement utilisateur correspondant à l'identifiant fourni.";

    case "invalid-email":
      return "L'adresse email fournie est incorect.";

    case "wrong-password":
      return "Le mot de passe fournie est incorect.";

    case "network-request-failed":
      return "Verifier votre connexion internet.";

    default:
      return "An undefined Error happened.";
  }
}
