// Données enrichies pour la base de données Heartalk
//
// Phase B: Enrichissement de la base de données
// - 100 questions par catégorie (90 nouvelles + 10 existantes)
// - 50 thèmes par catégorie (45 nouveaux + 5 existants)
// - Niveaux de difficulté variés (1 = Facile, 2 = Moyen, 3 = Difficile)

class DatabaseEnrichedData {
  // ========== QUESTIONS - EN COUPLE (90 nouvelles) ==========
  static const coupleQuestionsNew = [
    // Niveau 1 - Facile (30 questions)
    {'text': 'Quel est ton plat préféré que je cuisine ?', 'level': 1},
    {'text': 'Quelle est notre chanson préférée en couple ?', 'level': 1},
    {
      'text': 'Quel surnom affectueux préfères-tu que je t\'appelle ?',
      'level': 1,
    },
    {'text': 'Quel est ton film romantique préféré ?', 'level': 1},
    {
      'text': 'Quelle est ta saison préférée pour passer du temps ensemble ?',
      'level': 1,
    },
    {'text': 'Quel est ton restaurant préféré pour nos sorties ?', 'level': 1},
    {
      'text':
          'Quelle activité aimerais-tu qu\'on fasse plus souvent ensemble ?',
      'level': 1,
    },
    {
      'text': 'Quel est ton moment préféré de la journée avec moi ?',
      'level': 1,
    },
    {
      'text': 'Quelle destination de voyage rêves-tu de visiter avec moi ?',
      'level': 1,
    },
    {'text': 'Quel est ton meilleur souvenir de nos débuts ?', 'level': 1},
    {
      'text': 'Quelle est ta façon préférée de me dire je t\'aime ?',
      'level': 1,
    },
    {
      'text': 'Quel cadeau t\'ai-je offert qui t\'a le plus touché ?',
      'level': 1,
    },
    {'text': 'Quelle est ta tradition de couple préférée ?', 'level': 1},
    {'text': 'Quel est ton endroit préféré pour nos rendez-vous ?', 'level': 1},
    {'text': 'Quelle est ta photo préférée de nous deux ?', 'level': 1},
    {
      'text': 'Quel est ton genre de film préféré à regarder avec moi ?',
      'level': 1,
    },
    {'text': 'Quelle est ta position préférée pour les câlins ?', 'level': 1},
    {'text': 'Quel est ton dessert préféré à partager ?', 'level': 1},
    {'text': 'Quelle est ta saison préférée pour nos sorties ?', 'level': 1},
    {
      'text': 'Quel animal de compagnie aimerais-tu adopter ensemble ?',
      'level': 1,
    },
    {
      'text': 'Quelle est ta playlist préférée pour nos trajets en voiture ?',
      'level': 1,
    },
    {'text': 'Quel est ton petit déjeuner préféré au lit ?', 'level': 1},
    {'text': 'Quelle est ta fleur préférée que je t\'offre ?', 'level': 1},
    {'text': 'Quel est ton parfum préféré que je porte ?', 'level': 1},
    {
      'text': 'Quelle est ta couleur préférée pour me voir porter ?',
      'level': 1,
    },
    {
      'text': 'Quel est ton livre préféré que tu aimerais que je lise ?',
      'level': 1,
    },
    {'text': 'Quelle est ta série préférée à regarder en couple ?', 'level': 1},
    {'text': 'Quel est ton dessert préféré que je prépare ?', 'level': 1},
    {'text': 'Quelle est ta boisson préférée à siroter ensemble ?', 'level': 1},
    {'text': 'Quel est ton moment préféré du week-end avec moi ?', 'level': 1},

    // Niveau 2 - Moyen (30 questions)
    {
      'text': 'Qu\'est-ce qui te manque le plus quand on est séparés ?',
      'level': 2,
    },
    {
      'text': 'Quelle est la qualité que tu admires le plus chez moi ?',
      'level': 2,
    },
    {'text': 'Comment décrirais-tu notre relation en trois mots ?', 'level': 2},
    {
      'text': 'Quelle leçon importante notre relation t\'a-t-elle apprise ?',
      'level': 2,
    },
    {
      'text': 'Quel aspect de ta personnalité as-tu découvert grâce à moi ?',
      'level': 2,
    },
    {
      'text':
          'Quelle est la chose la plus romantique que j\'aie faite pour toi ?',
      'level': 2,
    },
    {
      'text': 'Comment aimerais-tu célébrer notre prochain anniversaire ?',
      'level': 2,
    },
    {
      'text':
          'Quelle promesse que je t\'ai faite est la plus importante pour toi ?',
      'level': 2,
    },
    {
      'text':
          'Quel compromis dans notre relation es-tu le plus fier(e) d\'avoir fait ?',
      'level': 2,
    },
    {
      'text': 'Quelle habitude de moi te fait sourire à chaque fois ?',
      'level': 2,
    },
    {'text': 'Quel défi aimerais-tu qu\'on relève ensemble ?', 'level': 2},
    {
      'text': 'Comment définirais-tu l\'amour à travers notre relation ?',
      'level': 2,
    },
    {
      'text':
          'Quelle est la chose la plus courageuse que tu aies faite pour notre relation ?',
      'level': 2,
    },
    {'text': 'Quel moment difficile nous a le plus rapprochés ?', 'level': 2},
    {'text': 'Quelle surprise aimerais-tu que je te fasse ?', 'level': 2},
    {
      'text': 'Quel aspect de notre communication aimerais-tu améliorer ?',
      'level': 2,
    },
    {
      'text':
          'Quelle valeur partageons-nous qui est la plus importante pour toi ?',
      'level': 2,
    },
    {
      'text':
          'Quel changement positif as-tu remarqué en toi depuis notre rencontre ?',
      'level': 2,
    },
    {
      'text': 'Quelle est ta plus grande fierté concernant notre couple ?',
      'level': 2,
    },
    {
      'text': 'Comment te sens-tu quand je te soutiens dans tes projets ?',
      'level': 2,
    },
    {
      'text': 'Quelle différence entre nous enrichit notre relation ?',
      'level': 2,
    },
    {
      'text': 'Quel souvenir de nous veux-tu créer dans les 6 prochains mois ?',
      'level': 2,
    },
    {
      'text':
          'Comment notre relation t\'a-t-elle aidé à grandir personnellement ?',
      'level': 2,
    },
    {
      'text': 'Quelle peur concernant notre relation as-tu surmontée ?',
      'level': 2,
    },
    {
      'text': 'Quel geste quotidien de ma part te fait te sentir aimé(e) ?',
      'level': 2,
    },
    {
      'text':
          'Quelle est la meilleure décision que nous ayons prise ensemble ?',
      'level': 2,
    },
    {
      'text': 'Comment aimerais-tu qu\'on gère nos désaccords à l\'avenir ?',
      'level': 2,
    },
    {
      'text': 'Quelle tradition aimerais-tu créer pour notre couple ?',
      'level': 2,
    },
    {
      'text': 'Quel aspect de notre intimité émotionnelle chéris-tu le plus ?',
      'level': 2,
    },
    {
      'text': 'Comment puis-je mieux montrer mon appréciation pour toi ?',
      'level': 2,
    },

    // Niveau 3 - Difficile (30 questions)
    {
      'text':
          'Quelle est ta plus grande insécurité dans notre relation et pourquoi ?',
      'level': 3,
    },
    {
      'text':
          'Y a-t-il quelque chose que tu ne m\'as jamais dit par peur de ma réaction ?',
      'level': 3,
    },
    {
      'text': 'Quel aspect de toi-même aimerais-tu que je comprenne mieux ?',
      'level': 3,
    },
    {
      'text':
          'Quelle blessure du passé affecte encore notre relation aujourd\'hui ?',
      'level': 3,
    },
    {
      'text':
          'Comment vois-tu évoluer nos priorités dans les 10 prochaines années ?',
      'level': 3,
    },
    {
      'text':
          'Quel sacrifice as-tu fait pour notre relation dont je ne suis peut-être pas conscient(e) ?',
      'level': 3,
    },
    {
      'text': 'Quelle conversation évites-tu d\'avoir avec moi et pourquoi ?',
      'level': 3,
    },
    {
      'text':
          'Comment notre relation pourrait-elle mieux soutenir tes ambitions personnelles ?',
      'level': 3,
    },
    {'text': 'Quelle attente non exprimée as-tu envers moi ?', 'level': 3},
    {
      'text': 'Quel aspect de notre relation te demande le plus d\'efforts ?',
      'level': 3,
    },
    {
      'text':
          'Comment pourrions-nous mieux gérer nos différences de besoins émotionnels ?',
      'level': 3,
    },
    {
      'text':
          'Quelle peur t\'empêche d\'être complètement vulnérable avec moi ?',
      'level': 3,
    },
    {
      'text':
          'Y a-t-il un besoin non satisfait dans notre relation dont tu n\'as jamais parlé ?',
      'level': 3,
    },
    {
      'text':
          'Comment notre relation influence-t-elle ta perception de toi-même ?',
      'level': 3,
    },
    {
      'text': 'Quel conflit non résolu penses-tu qu\'on devrait aborder ?',
      'level': 3,
    },
    {
      'text': 'Comment aimerais-tu que j\'évolue pour notre avenir ensemble ?',
      'level': 3,
    },
    {
      'text':
          'Quelle limite personnelle as-tu du mal à maintenir dans notre relation ?',
      'level': 3,
    },
    {
      'text':
          'Quel rêve as-tu mis de côté pour notre couple et comment te sens-tu à ce sujet ?',
      'level': 3,
    },
    {
      'text':
          'Comment notre relation pourrait-elle mieux respecter ton besoin d\'indépendance ?',
      'level': 3,
    },
    {
      'text':
          'Quelle partie de ton passé affecte encore ta façon d\'aimer aujourd\'hui ?',
      'level': 3,
    },
    {
      'text':
          'Quel changement aimerais-tu voir en moi mais que tu hésites à demander ?',
      'level': 3,
    },
    {
      'text':
          'Comment pourrions-nous créer plus d\'espace pour ta croissance personnelle ?',
      'level': 3,
    },
    {'text': 'Quelle vulnérabilité de toi me caches-tu encore ?', 'level': 3},
    {
      'text':
          'Comment notre dynamique de couple pourrait-elle être plus équilibrée ?',
      'level': 3,
    },
    {
      'text':
          'Quel pattern négatif de tes relations passées crains-tu de répéter avec moi ?',
      'level': 3,
    },
    {
      'text':
          'Comment pourrions-nous mieux naviguer nos différences de vision de l\'avenir ?',
      'level': 3,
    },
    {
      'text':
          'Quelle partie de ta vérité émotionnelle as-tu peur de partager ?',
      'level': 3,
    },
    {
      'text':
          'Comment notre relation pourrait-elle mieux honorer ton authenticité ?',
      'level': 3,
    },
    {
      'text':
          'Quel besoin émotionnel non comblé te pousse parfois à te distancer ?',
      'level': 3,
    },
    {
      'text':
          'Quelle transformation personnelle aimerais-tu accomplir avec mon soutien ?',
      'level': 3,
    },
  ];

  // ========== QUESTIONS - EN AMOUREUX (90 nouvelles) ==========
  static const amoureuxQuestionsNew = [
    // Niveau 1 - Facile (30 questions)
    {'text': 'Quel est ton genre de musique préféré ?', 'level': 1},
    {'text': 'Quelle est ta couleur préférée ?', 'level': 1},
    {'text': 'Quel est ton plat préféré ?', 'level': 1},
    {'text': 'Quelle est ta saison préférée et pourquoi ?', 'level': 1},
    {'text': 'Quel est ton animal préféré ?', 'level': 1},
    {'text': 'Quelle est ta boisson préférée ?', 'level': 1},
    {'text': 'Quel est ton dessert favori ?', 'level': 1},
    {'text': 'Quelle est ta fleur préférée ?', 'level': 1},
    {
      'text': 'Quel est ton sport préféré à pratiquer ou regarder ?',
      'level': 1,
    },
    {'text': 'Quelle est ta destination de vacances idéale ?', 'level': 1},
    {'text': 'Quel est ton jour de la semaine préféré ?', 'level': 1},
    {'text': 'Quelle est ta série TV préférée du moment ?', 'level': 1},
    {'text': 'Quel est ton acteur ou actrice préféré(e) ?', 'level': 1},
    {'text': 'Quelle est ta marque de vêtements préférée ?', 'level': 1},
    {'text': 'Quel est ton parfum préféré ?', 'level': 1},
    {'text': 'Quelle est ta voiture de rêve ?', 'level': 1},
    {'text': 'Quel est ton jeu vidéo préféré ?', 'level': 1},
    {
      'text': 'Quelle est ta application préférée sur ton téléphone ?',
      'level': 1,
    },
    {'text': 'Quel est ton réseau social préféré ?', 'level': 1},
    {'text': 'Quelle est ta pizza préférée ?', 'level': 1},
    {'text': 'Quel est ton café ou thé préféré ?', 'level': 1},
    {'text': 'Quelle est ta glace préférée ?', 'level': 1},
    {'text': 'Quel est ton fruit préféré ?', 'level': 1},
    {'text': 'Quelle est ta matière scolaire préférée ?', 'level': 1},
    {
      'text': 'Quel est ton style de décoration d\'intérieur préféré ?',
      'level': 1,
    },
    {'text': 'Quelle est ta période de l\'année préférée ?', 'level': 1},
    {'text': 'Quel est ton type d\'exercice physique préféré ?', 'level': 1},
    {'text': 'Quelle est ta langue étrangère préférée ?', 'level': 1},
    {'text': 'Quel est ton type de restauration rapide préféré ?', 'level': 1},
    {'text': 'Quelle est ta marque de smartphone préférée ?', 'level': 1},

    // Niveau 2 - Moyen (30 questions)
    {
      'text':
          'Quelle est la qualité que tu recherches le plus chez un(e) partenaire ?',
      'level': 2,
    },
    {'text': 'Quel est ton love language principal ?', 'level': 2},
    {'text': 'Quelle est ta définition d\'une relation saine ?', 'level': 2},
    {
      'text': 'Quel trait de personnalité te rend unique selon toi ?',
      'level': 2,
    },
    {
      'text': 'Quelle est ton approche face aux conflits dans une relation ?',
      'level': 2,
    },
    {'text': 'Quel est ton objectif professionnel à court terme ?', 'level': 2},
    {
      'text': 'Quelle valeur familiale est la plus importante pour toi ?',
      'level': 2,
    },
    {'text': 'Comment gères-tu le stress au quotidien ?', 'level': 2},
    {
      'text': 'Quelle expérience t\'a le plus fait grandir personnellement ?',
      'level': 2,
    },
    {
      'text': 'Quel type de communication préfères-tu dans une relation ?',
      'level': 2,
    },
    {
      'text': 'Quelle est ta vision de l\'équilibre vie pro/vie perso ?',
      'level': 2,
    },
    {'text': 'Quel est ton style d\'attachement en amour ?', 'level': 2},
    {'text': 'Quelle habitude aimerais-tu développer ou changer ?', 'level': 2},
    {'text': 'Comment exprimes-tu ton affection en général ?', 'level': 2},
    {'text': 'Quelle est ton attitude face au changement ?', 'level': 2},
    {
      'text':
          'Quel type de soutien apprécies-tu le plus dans les moments difficiles ?',
      'level': 2,
    },
    {'text': 'Quelle est ta philosophie de vie en une phrase ?', 'level': 2},
    {
      'text':
          'Comment équilibres-tu indépendance et intimité dans une relation ?',
      'level': 2,
    },
    {'text': 'Quel est ton rapport à l\'argent et aux finances ?', 'level': 2},
    {
      'text': 'Quelle est ton approche de la spiritualité ou de la religion ?',
      'level': 2,
    },
    {'text': 'Comment gères-tu la jalousie dans une relation ?', 'level': 2},
    {
      'text': 'Quelle est ton opinion sur les relations à distance ?',
      'level': 2,
    },
    {
      'text': 'Comment vois-tu le rôle de l\'amitié dans un couple ?',
      'level': 2,
    },
    {
      'text': 'Quelle est ta position sur les enfants et la parentalité ?',
      'level': 2,
    },
    {'text': 'Comment préfères-tu résoudre les malentendus ?', 'level': 2},
    {
      'text':
          'Quel est ton niveau d\'aisance avec la vulnérabilité émotionnelle ?',
      'level': 2,
    },
    {
      'text': 'Quelle est ton attitude face aux traditions familiales ?',
      'level': 2,
    },
    {'text': 'Comment définis-tu la confiance dans une relation ?', 'level': 2},
    {
      'text': 'Quel est ton besoin d\'espace personnel dans une relation ?',
      'level': 2,
    },
    {
      'text': 'Comment envisages-tu de célébrer les moments importants ?',
      'level': 2,
    },

    // Niveau 3 - Difficile (30 questions)
    {
      'text':
          'Quelle blessure émotionnelle non guérie influences encore tes relations ?',
      'level': 3,
    },
    {
      'text':
          'Quel pattern de tes relations passées souhaites-tu transformer ?',
      'level': 3,
    },
    {
      'text': 'Quelle peur profonde t\'empêche de t\'ouvrir complètement ?',
      'level': 3,
    },
    {
      'text':
          'Quel aspect de ton enfance affecte ta façon d\'aimer aujourd\'hui ?',
      'level': 3,
    },
    {
      'text': 'Quelle vérité sur toi-même as-tu du mal à accepter ?',
      'level': 3,
    },
    {
      'text': 'Quel besoin émotionnel fondamental n\'a jamais été comblé ?',
      'level': 3,
    },
    {
      'text':
          'Quelle partie de ta personnalité caches-tu généralement et pourquoi ?',
      'level': 3,
    },
    {
      'text':
          'Quel traumatisme du passé influences encore tes décisions actuelles ?',
      'level': 3,
    },
    {
      'text': 'Quelle croyance limitante sur l\'amour aimerais-tu dépasser ?',
      'level': 3,
    },
    {
      'text':
          'Quel sacrifice personnel serais-tu prêt(e) à faire pour l\'amour ?',
      'level': 3,
    },
    {'text': 'Quelle vulnérabilité te coûte le plus de montrer ?', 'level': 3},
    {
      'text': 'Quel conflit intérieur non résolu affecte tes relations ?',
      'level': 3,
    },
    {
      'text':
          'Quelle transformation personnelle profonde souhaites-tu accomplir ?',
      'level': 3,
    },
    {
      'text':
          'Quel mécanisme de défense utilises-tu le plus dans l\'intimité ?',
      'level': 3,
    },
    {
      'text': 'Quelle partie de ton authenticité as-tu peur de révéler ?',
      'level': 3,
    },
    {
      'text':
          'Quel besoin affectif non exprimé causes des tensions dans tes relations ?',
      'level': 3,
    },
    {
      'text':
          'Quelle limite personnelle as-tu du mal à maintenir par peur d\'être rejeté(e) ?',
      'level': 3,
    },
    {
      'text':
          'Quel aspect de l\'intimité émotionnelle te met le plus mal à l\'aise ?',
      'level': 3,
    },
    {
      'text':
          'Quelle attente irréaliste portes-tu sur les relations amoureuses ?',
      'level': 3,
    },
    {
      'text':
          'Quel schéma familial dysfonctionnel reproduis-tu inconsciemment ?',
      'level': 3,
    },
    {
      'text':
          'Quelle peur d\'abandon influences tes comportements relationnels ?',
      'level': 3,
    },
    {
      'text':
          'Quel aspect de toi rejettes-tu qui pourrait enrichir une relation ?',
      'level': 3,
    },
    {'text': 'Quelle dépendance émotionnelle aimerais-tu guérir ?', 'level': 3},
    {
      'text':
          'Quel travail de développement personnel es-tu prêt(e) à faire pour mieux aimer ?',
      'level': 3,
    },
    {
      'text':
          'Quelle partie de ton ombre psychologique affecte tes relations ?',
      'level': 3,
    },
    {
      'text': 'Quel pardon envers toi-même te libérerait dans tes relations ?',
      'level': 3,
    },
    {
      'text':
          'Quelle blessure narcissique influences ta capacité à recevoir l\'amour ?',
      'level': 3,
    },
    {
      'text':
          'Quel pattern d\'auto-sabotage as-tu identifié dans tes relations ?',
      'level': 3,
    },
    {
      'text':
          'Quelle réconciliation avec ton passé permettrait une relation plus saine ?',
      'level': 3,
    },
    {
      'text':
          'Quel aspect de ta croissance émotionnelle nécessite le plus d\'attention ?',
      'level': 3,
    },
  ];

  // ========== QUESTIONS - ENTRE AMIS (90 nouvelles) ==========
  static const amisQuestionsNew = [
    // Niveau 1 - Facile (30 questions)
    {'text': 'Quel est ton emoji préféré à utiliser ?', 'level': 1},
    {'text': 'Quelle est ta blague préférée ?', 'level': 1},
    {'text': 'Quel est ton mème internet préféré ?', 'level': 1},
    {'text': 'Quelle est ta youtubeuse ou youtubeur préféré ?', 'level': 1},
    {'text': 'Quel est ton challenge TikTok préféré ?', 'level': 1},
    {'text': 'Quelle est ta chanson préférée du moment ?', 'level': 1},
    {'text': 'Quel est ton filtre Instagram préféré ?', 'level': 1},
    {'text': 'Quelle est ta série Netflix préférée ?', 'level': 1},
    {'text': 'Quel est ton jeu de société préféré ?', 'level': 1},
    {'text': 'Quelle est ta console de jeux préférée ?', 'level': 1},
    {'text': 'Quel est ton super-héros Marvel ou DC préféré ?', 'level': 1},
    {'text': 'Quelle est ta saga de films préférée ?', 'level': 1},
    {'text': 'Quel est ton genre de manga préféré ?', 'level': 1},
    {'text': 'Quelle est ta marque de sneakers préférée ?', 'level': 1},
    {'text': 'Quel est ton style vestimentaire préféré ?', 'level': 1},
    {'text': 'Quelle est ta coiffure préférée ?', 'level': 1},
    {'text': 'Quel est ton accessoire mode préféré ?', 'level': 1},
    {'text': 'Quelle est ta marque de fast-food préférée ?', 'level': 1},
    {'text': 'Quel est ton bonbon ou snack préféré ?', 'level': 1},
    {'text': 'Quelle est ta boisson énergisante préférée ?', 'level': 1},
    {'text': 'Quel est ton parc d\'attractions préféré ?', 'level': 1},
    {'text': 'Quelle est ta fête ou festival préféré ?', 'level': 1},
    {'text': 'Quel est ton sport extrême préféré ?', 'level': 1},
    {'text': 'Quelle est ta danse préférée ?', 'level': 1},
    {'text': 'Quel est ton instrument de musique préféré ?', 'level': 1},
    {'text': 'Quelle est ta plateforme de streaming préférée ?', 'level': 1},
    {'text': 'Quel est ton podcast préféré ?', 'level': 1},
    {'text': 'Quelle est ta BD ou comics préféré ?', 'level': 1},
    {'text': 'Quel est ton type de contenu TikTok préféré ?', 'level': 1},
    {'text': 'Quelle est ta personnalité publique préférée ?', 'level': 1},

    // Niveau 2 - Moyen (30 questions)
    {
      'text': 'Quelle aventure épique aimerais-tu vivre avec tes amis ?',
      'level': 2,
    },
    {
      'text': 'Quel talent secret possèdes-tu que peu de gens connaissent ?',
      'level': 2,
    },
    {'text': 'Quelle cause sociale te passionne le plus ?', 'level': 2},
    {'text': 'Quel changement aimerais-tu voir dans le monde ?', 'level': 2},
    {'text': 'Quelle expérience t\'a le plus marqué dans ta vie ?', 'level': 2},
    {
      'text': 'Quel défi personnel es-tu en train de relever actuellement ?',
      'level': 2,
    },
    {
      'text': 'Quelle leçon de vie importante as-tu apprise récemment ?',
      'level': 2,
    },
    {'text': 'Quel projet créatif aimerais-tu réaliser ?', 'level': 2},
    {'text': 'Quelle peur as-tu surmontée dont tu es fier(e) ?', 'level': 2},
    {'text': 'Quel conseil donnerais-tu à ton moi du passé ?', 'level': 2},
    {
      'text':
          'Quelle compétence aimerais-tu maîtriser dans les 5 prochaines années ?',
      'level': 2,
    },
    {'text': 'Quel est ton plus grand accomplissement personnel ?', 'level': 2},
    {'text': 'Quelle injustice t\'émeut particulièrement ?', 'level': 2},
    {
      'text': 'Quel changement de carrière envisages-tu ou rêves-tu de faire ?',
      'level': 2,
    },
    {
      'text': 'Quelle tradition familiale aimerais-tu perpétuer ou changer ?',
      'level': 2,
    },
    {
      'text': 'Quel sacrifice as-tu fait qui en valait vraiment la peine ?',
      'level': 2,
    },
    {
      'text': 'Quelle qualité admires-tu le plus chez tes amis proches ?',
      'level': 2,
    },
    {'text': 'Quel moment de ta vie aimerais-tu revivre ?', 'level': 2},
    {
      'text': 'Quelle décision difficile as-tu prise qui t\'a fait grandir ?',
      'level': 2,
    },
    {
      'text': 'Quel rêve d\'enfance as-tu réalisé ou espères réaliser ?',
      'level': 2,
    },
    {
      'text':
          'Quelle relation importante as-tu dû laisser partir et pourquoi ?',
      'level': 2,
    },
    {'text': 'Quel mentor ou modèle a le plus influencé ta vie ?', 'level': 2},
    {
      'text': 'Quelle habitude de vie as-tu changée qui t\'a transformé ?',
      'level': 2,
    },
    {
      'text': 'Quel événement mondial t\'a le plus affecté personnellement ?',
      'level': 2,
    },
    {'text': 'Quelle contribution veux-tu laisser au monde ?', 'level': 2},
    {
      'text': 'Quel échec t\'a enseigné la leçon la plus précieuse ?',
      'level': 2,
    },
    {
      'text': 'Quelle passion aimerais-tu transformer en carrière ?',
      'level': 2,
    },
    {
      'text': 'Quel aspect de ta personnalité as-tu appris à embrasser ?',
      'level': 2,
    },
    {
      'text': 'Quelle expérience culturelle t\'a ouvert l\'esprit ?',
      'level': 2,
    },
    {
      'text': 'Quel objectif de vie es-tu déterminé(e) à atteindre ?',
      'level': 2,
    },

    // Niveau 3 - Difficile (30 questions)
    {
      'text': 'Quelle vérité sur toi-même as-tu longtemps refusé d\'accepter ?',
      'level': 3,
    },
    {
      'text': 'Quel regret profond portes-tu que tu n\'as jamais partagé ?',
      'level': 3,
    },
    {
      'text': 'Quelle partie de ton identité as-tu dû cacher ou supprimer ?',
      'level': 3,
    },
    {
      'text': 'Quel trauma ou épreuve t\'a fondamentalement changé ?',
      'level': 3,
    },
    {'text': 'Quelle bataille intérieure mènes-tu en silence ?', 'level': 3},
    {
      'text': 'Quel jugement des autres te blesse le plus profondément ?',
      'level': 3,
    },
    {
      'text': 'Quelle partie de ton passé aimerais-tu pouvoir effacer ?',
      'level': 3,
    },
    {'text': 'Quel secret portes-tu qui pèse sur ta conscience ?', 'level': 3},
    {
      'text': 'Quelle peur irrationnelle contrôle certaines de tes décisions ?',
      'level': 3,
    },
    {'text': 'Quel pardon (envers toi ou autrui) te libérerait ?', 'level': 3},
    {
      'text': 'Quelle relation toxique as-tu du mal à quitter définitivement ?',
      'level': 3,
    },
    {'text': 'Quel aspect de ta santé mentale négliges-tu ?', 'level': 3},
    {'text': 'Quelle croyance limitante sabote tes rêves ?', 'level': 3},
    {
      'text':
          'Quel deuil (personne, rêve, identité) n\'as-tu pas encore fait ?',
      'level': 3,
    },
    {
      'text': 'Quelle injustice subie continues-tu de porter en toi ?',
      'level': 3,
    },
    {
      'text': 'Quel pattern d\'auto-destruction répètes-tu malgré toi ?',
      'level': 3,
    },
    {'text': 'Quelle vulnérabilité t\'es-tu interdit de montrer ?', 'level': 3},
    {
      'text': 'Quel mensonge te racontes-tu pour éviter de changer ?',
      'level': 3,
    },
    {
      'text': 'Quelle partie de ton enfance nécessite encore une guérison ?',
      'level': 3,
    },
    {'text': 'Quel besoin fondamental as-tu renoncé à combler ?', 'level': 3},
    {
      'text': 'Quelle honte non résolue influences tes comportements ?',
      'level': 3,
    },
    {'text': 'Quel appel de ton âme ignores-tu par peur ?', 'level': 3},
    {
      'text': 'Quelle version de toi as-tu abandonné en cours de route ?',
      'level': 3,
    },
    {'text': 'Quel conflit de valeurs internes te déchire ?', 'level': 3},
    {
      'text':
          'Quelle dépendance (substance, personne, comportement) reconnais-tu avoir ?',
      'level': 3,
    },
    {'text': 'Quel masque social portes-tu qui t\'épuise ?', 'level': 3},
    {
      'text': 'Quelle colère refoulée affecte ta santé et tes relations ?',
      'level': 3,
    },
    {
      'text': 'Quel rêve as-tu enterré par défaitisme ou découragement ?',
      'level': 3,
    },
    {
      'text': 'Quelle réconciliation avec ton histoire familiale te manque ?',
      'level': 3,
    },
    {
      'text': 'Quel aspect de ta véritable essence as-tu peur de libérer ?',
      'level': 3,
    },
  ];
}
