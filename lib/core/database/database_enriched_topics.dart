// Thèmes enrichis pour la base de données Heartalk
//
// Phase B: Enrichissement des thèmes de discussion
// - 50 thèmes par catégorie (45 nouveaux + 5 existants)
// - Niveaux de difficulté variés (1 = Léger, 2 = Moyen, 3 = Profond)
// - Durée : 300 secondes (5 minutes) par défaut

class DatabaseEnrichedTopics {
  // ========== THÈMES - EN COUPLE (45 nouveaux) ==========
  static const coupleTopicsNew = [
    // Niveau 1 - Léger (15 thèmes)
    {
      'text': 'Partagez vos moments préférés de la semaine passée ensemble',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de votre prochaine sortie ou activité de couple',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos plats préférés et planifiez un dîner spécial',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos séries ou films préférés à regarder ensemble',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos surnoms affectueux favoris',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Partagez vos souvenirs de vos premiers rendez-vous',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez les petites attentions qui vous touchent le plus',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de votre playlist couple idéale',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos destinations de vacances de rêve',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez les cadeaux qui vous ont le plus marqués',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos rituels matinaux ou du soir préférés',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Partagez vos activités de week-end favorites ensemble',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos traditions de couple que vous chérissez',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos restaurants préférés et pourquoi',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Parlez de ce qui vous fait rire aux éclats ensemble',
      'level': 1,
      'duration': 300,
    },

    // Niveau 2 - Moyen (15 thèmes)
    {
      'text': 'Discutez de vos objectifs de couple pour l\'année à venir',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Partagez comment vous gérez le stress et comment vous soutenir mutuellement',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Évoquez les compromis importants que vous avez faits dans votre relation',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos visions respectives de la famille et du foyer',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Parlez de comment vous équilibrez vie professionnelle et vie de couple',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Évoquez les moments où vous vous êtes sentis vraiment compris par l\'autre',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos façons préférées de résoudre les conflits',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Partagez ce que vous avez appris l\'un de l\'autre',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Évoquez comment vous célébrez vos réussites respectives',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Discutez de vos besoins d\'espace personnel et de temps ensemble',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos valeurs communes et de leur importance',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Évoquez les défis que vous avez relevés ensemble et ce qu\'ils vous ont appris',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Discutez de comment vous maintenez la spontanéité dans votre relation',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Partagez vos aspirations individuelles et comment les soutenir mutuellement',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Évoquez comment vous gardez la romance vivante au quotidien',
      'level': 2,
      'duration': 300,
    },

    // Niveau 3 - Profond (15 thèmes)
    {
      'text':
          'Discutez de vos peurs les plus profondes concernant votre avenir ensemble',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Partagez les blessures du passé qui affectent encore votre relation',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Évoquez vos besoins émotionnels non exprimés et comment y répondre',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Discutez de comment vous évoluez individuellement et en tant que couple',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Parlez de vos vulnérabilités et comment créer un espace sûr pour les partager',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Évoquez les patterns négatifs que vous souhaitez transformer ensemble',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Discutez de comment vos familles d\'origine influencent votre relation',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Partagez vos définitions respectives de l\'intimité émotionnelle',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Évoquez comment vous gérez les déséquilibres de pouvoir dans la relation',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Discutez de vos attentes tacites et de leur impact sur votre couple',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Parlez de comment vous naviguez les différences dans vos styles d\'attachement',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Évoquez les sacrifices personnels et comment maintenir votre authenticité',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Discutez de comment vous créez un équilibre entre fusion et indépendance',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Partagez vos réflexions sur la croissance sexuelle et l\'intimité physique',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Évoquez comment vous envisagez de vieillir ensemble et vos craintes associées',
      'level': 3,
      'duration': 300,
    },
  ];

  // ========== THÈMES - EN AMOUREUX (45 nouveaux) ==========
  static const amoureuxTopicsNew = [
    // Niveau 1 - Léger (15 thèmes)
    {
      'text': 'Partagez vos musiques préférées et pourquoi elles vous touchent',
      'level': 1,
      'duration': 300,
    },
    {
      'text':
          'Discutez de vos films d\'amour favoris et ce qui les rend spéciaux',
      'level': 1,
      'duration': 300,
    },
    {
      'text':
          'Évoquez vos loisirs et comment vous aimez passer votre temps libre',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos animaux préférés et pourquoi',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos saisons favorites et les souvenirs associés',
      'level': 1,
      'duration': 300,
    },
    {
      'text':
          'Partagez vos plats réconfortants préférés et les histoires derrière',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos destinations de voyage rêvées',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos célébrités ou personnalités inspirantes',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos sports ou activités physiques favorites',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos séries Netflix ou films récents préférés',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos styles vestimentaires et ce qui vous inspire',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Partagez vos moments de détente idéaux',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos artistes musicaux préférés et concerts mémorables',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos jeux ou activités ludiques favorites',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos routines matinales ou du soir',
      'level': 1,
      'duration': 300,
    },

    // Niveau 2 - Moyen (15 thèmes)
    {
      'text': 'Discutez de vos objectifs de vie à court et long terme',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Partagez vos philosophies de vie et ce qui guide vos décisions',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Évoquez vos relations familiales et leur impact sur qui vous êtes',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos carrières et aspirations professionnelles',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Parlez de comment vous gérez le stress et les difficultés',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos plus grandes fiertés et accomplissements',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos valeurs fondamentales et leurs origines',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Partagez vos expériences qui vous ont le plus transformés',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Évoquez vos relations amicales et ce que l\'amitié signifie pour vous',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Discutez de votre rapport à l\'argent et aux finances',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos croyances spirituelles ou religieuses',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Évoquez comment vous exprimez votre amour et affection',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos rêves d\'enfance et ce qu\'ils sont devenus',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Partagez vos définitions du bonheur et comment l\'atteindre',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Évoquez vos styles de communication et comment vous résolvez les conflits',
      'level': 2,
      'duration': 300,
    },

    // Niveau 3 - Profond (15 thèmes)
    {
      'text':
          'Discutez de vos blessures émotionnelles non guéries et leur impact',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Partagez vos peurs les plus profondes concernant l\'amour et l\'intimité',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Évoquez les patterns de vos relations passées et ce que vous en avez appris',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Discutez de vos insécurités et comment elles affectent vos relations',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Parlez de vos besoins émotionnels fondamentaux et s\'ils sont comblés',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos mécanismes de défense et comment ils vous protègent',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Discutez de comment votre enfance influence vos relations actuelles',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Partagez les aspects de vous-même que vous cachez généralement',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos styles d\'attachement et comment ils se manifestent',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Discutez de vos croyances limitantes sur l\'amour et les relations',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Parlez de votre relation à la vulnérabilité et l\'authenticité',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Évoquez les traumatismes passés et leur résolution',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos attentes inconscientes dans les relations',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Partagez votre vision de la croissance personnelle et émotionnelle',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Évoquez comment vous équilibrez indépendance et interdépendance',
      'level': 3,
      'duration': 300,
    },
  ];

  // ========== THÈMES - ENTRE AMIS (45 nouveaux) ==========
  static const amisTopicsNew = [
    // Niveau 1 - Léger (15 thèmes)
    {
      'text':
          'Partagez vos anecdotes les plus drôles de l\'école ou du travail',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos personnalités de réseaux sociaux préférées',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos mèmes et trends internet favoris',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos jeux vidéo préférés et pourquoi',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos youtubeurs ou streamers favoris',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Partagez vos playlists Spotify ou Apple Music',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos festivals ou concerts mémorables',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos applications mobiles indispensables',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos séries animées ou manga préférés',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos destinations de soirée favorites',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos styles de mode préférés',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Partagez vos expériences de shopping mémorables',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos activités sportives ou de fitness favorites',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos fast-foods et snacks préférés',
      'level': 1,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos projets créatifs ou hobbies actuels',
      'level': 1,
      'duration': 300,
    },

    // Niveau 2 - Moyen (15 thèmes)
    {
      'text':
          'Discutez de vos ambitions professionnelles et ce qui vous motive',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Partagez vos plus grandes leçons de vie apprises',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Évoquez les moments où vous avez dû faire des choix difficiles',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos relations familiales et leur évolution',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos succès et ce qu\'ils vous ont appris',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos échecs et comment vous vous en êtes relevés',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Discutez de causes sociales ou politiques qui vous tiennent à cœur',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Partagez vos expériences de voyage qui vous ont transformés',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos mentors ou personnes influentes dans votre vie',
      'level': 2,
      'duration': 300,
    },
    {
      'text':
          'Discutez de vos plus grandes peurs et comment vous les affrontez',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Parlez de vos talents cachés et compétences que vous développez',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Évoquez vos changements de perspective importants',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Discutez de comment vous gérez le stress et la pression',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Partagez vos objectifs de développement personnel',
      'level': 2,
      'duration': 300,
    },
    {
      'text': 'Évoquez ce que l\'amitié signifie vraiment pour vous',
      'level': 2,
      'duration': 300,
    },

    // Niveau 3 - Profond (15 thèmes)
    {
      'text': 'Discutez de vos traumas non résolus et leur impact actuel',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Partagez vos plus grands regrets et ce qu\'ils vous enseignent',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Évoquez les parties de votre identité que vous avez dû cacher',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Discutez de vos crises existentielles et comment vous les traversez',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Parlez de vos relations toxiques passées et ce que vous en avez appris',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Évoquez vos problèmes de santé mentale et votre parcours de guérison',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Discutez de vos addictions ou dépendances (substances, comportements)',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Partagez vos hontes profondes et comment vous travaillez à les surmonter',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Évoquez les moments où vous avez envisagé d\'abandonner',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos conflits de valeurs internes qui vous déchirent',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Parlez de votre relation à l\'authenticité et aux masques sociaux',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Évoquez les injustices subies qui vous hantent encore',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Discutez de vos patterns d\'auto-sabotage et leurs origines',
      'level': 3,
      'duration': 300,
    },
    {
      'text': 'Partagez vos pensées sur la mort et le sens de la vie',
      'level': 3,
      'duration': 300,
    },
    {
      'text':
          'Évoquez les transformations personnelles que vous devez encore accomplir',
      'level': 3,
      'duration': 300,
    },
  ];
}
