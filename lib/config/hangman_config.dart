// ============================================================
// CONFIGURAÇÃO DOS 10 NÍVEIS DO JOGO DA FORCA - CristinaKids
// ============================================================
// Quer mudar palavras, dicas ou dificuldade?
// Mude AQUI!
// ============================================================

class HangmanWord {
  final String word;
  final String hint;

  const HangmanWord(this.word, this.hint);
}

class HangmanLevelData {
  final int level;
  final String name;
  final List<HangmanWord> words; // Banco de palavras (10+), sorteia 5 por partida
  final int maxErrors;
  final int threeStarErrors;
  final int twoStarErrors;

  const HangmanLevelData({
    required this.level,
    required this.name,
    required this.words,
    required this.maxErrors,
    required this.threeStarErrors,
    required this.twoStarErrors,
  });
}

class HangmanConfig {
  static const int wordsPerLevel = 5; // Quantas palavras por partida

  static final List<HangmanLevelData> levels = [
    // NÍVEL 1 - Bebê (3 letras)
    const HangmanLevelData(
      level: 1,
      name: 'Bebê',
      maxErrors: 7,
      threeStarErrors: 1,
      twoStarErrors: 3,
      words: [
        HangmanWord('BOI', 'Animal da fazenda que muge'),
        HangmanWord('CÃO', 'Melhor amigo do homem'),
        HangmanWord('AVE', 'Tem penas e voa'),
        HangmanWord('RÃ', 'Vive na lagoa e pula'),
        HangmanWord('LUA', 'Brilha no céu à noite'),
        HangmanWord('SOL', 'Esquenta a Terra'),
        HangmanWord('MAR', 'Tem água salgada'),
        HangmanWord('RIO', 'Água doce que corre'),
        HangmanWord('CÉU', 'Fica acima de nós'),
        HangmanWord('PÃO', 'Alimento feito de farinha'),
      ],
    ),

    // NÍVEL 2 - Iniciante (4 letras)
    const HangmanLevelData(
      level: 2,
      name: 'Iniciante',
      maxErrors: 7,
      threeStarErrors: 1,
      twoStarErrors: 3,
      words: [
        HangmanWord('PERA', 'Fruta verde e doce'),
        HangmanWord('KIWI', 'Fruta peluda por fora'),
        HangmanWord('COCO', 'Fruta com água dentro'),
        HangmanWord('LIMA', 'Fruta cítrica verde'),
        HangmanWord('GATO', 'Felino doméstico que mia'),
        HangmanWord('BOLA', 'Redonda e quica'),
        HangmanWord('MESA', 'Móvel com quatro pernas'),
        HangmanWord('RODA', 'Gira e gira sem parar'),
        HangmanWord('LEÃO', 'Rei da selva'),
        HangmanWord('DADO', 'Tem seis lados com números'),
      ],
    ),

    // NÍVEL 3 - Curioso (4-5 letras, natureza)
    const HangmanLevelData(
      level: 3,
      name: 'Curioso',
      maxErrors: 7,
      threeStarErrors: 1,
      twoStarErrors: 3,
      words: [
        HangmanWord('FLOR', 'Nasce no jardim'),
        HangmanWord('NEVE', 'Cai no inverno'),
        HangmanWord('NUVEM', 'Flutua no céu branca'),
        HangmanWord('FOLHA', 'Cai da árvore no outono'),
        HangmanWord('PEDRA', 'Dura e pesada'),
        HangmanWord('VENTO', 'Faz as árvores balançarem'),
        HangmanWord('TERRA', 'Nosso planeta'),
        HangmanWord('CHUVA', 'Cai das nuvens'),
        HangmanWord('PRAIA', 'Areia e mar juntos'),
        HangmanWord('PLANTA', 'Ser vivo que faz fotossíntese'),
      ],
    ),

    // NÍVEL 4 - Esperto (5 letras, animais)
    const HangmanLevelData(
      level: 4,
      name: 'Esperto',
      maxErrors: 6,
      threeStarErrors: 1,
      twoStarErrors: 3,
      words: [
        HangmanWord('TIGRE', 'Felino com listras'),
        HangmanWord('COBRA', 'Réptil sem patas'),
        HangmanWord('PEIXE', 'Nada no rio e no mar'),
        HangmanWord('SAPO', 'Parente da rã'),
        HangmanWord('PATO', 'Faz quá-quá'),
        HangmanWord('URSO', 'Grande e peludo'),
        HangmanWord('LOBO', 'Uiva pra lua'),
        HangmanWord('BALEIA', 'Maior mamífero do mar'),
        HangmanWord('CORUJA', 'Ave noturna sábia'),
        HangmanWord('CAVALO', 'Corre rápido e relincha'),
      ],
    ),

    // NÍVEL 5 - Inteligente (5-6 letras, objetos e escola)
    const HangmanLevelData(
      level: 5,
      name: 'Inteligente',
      maxErrors: 6,
      threeStarErrors: 1,
      twoStarErrors: 3,
      words: [
        HangmanWord('ESCOLA', 'Lugar de estudar'),
        HangmanWord('LIVRO', 'Tem páginas e história'),
        HangmanWord('LÁPIS', 'Usado pra escrever'),
        HangmanWord('JANELA', 'Abre pra ver o mundo'),
        HangmanWord('CADERNO', 'Escrevemos nele na escola'),
        HangmanWord('RELÓGIO', 'Mostra as horas'),
        HangmanWord('CHAVE', 'Abre a porta'),
        HangmanWord('ESPELHO', 'Mostra nosso reflexo'),
        HangmanWord('MOCHILA', 'Carregamos nas costas'),
        HangmanWord('TESOURA', 'Corta papel'),
      ],
    ),

    // NÍVEL 6 - Desafiador (6 letras, alimentos)
    const HangmanLevelData(
      level: 6,
      name: 'Desafiador',
      maxErrors: 6,
      threeStarErrors: 1,
      twoStarErrors: 3,
      words: [
        HangmanWord('BANANA', 'Fruta amarela e curva'),
        HangmanWord('CEREJA', 'Fruta vermelha pequena'),
        HangmanWord('GOIABA', 'Fruta rosa por dentro'),
        HangmanWord('QUEIJO', 'Feito de leite'),
        HangmanWord('FEIJÃO', 'Parceiro do arroz'),
        HangmanWord('TOMATE', 'Vermelho e usado em molho'),
        HangmanWord('CENOURA', 'Legume laranja do coelho'),
        HangmanWord('ABACATE', 'Fruta verde com caroço grande'),
        HangmanWord('ALFACE', 'Folha verde da salada'),
        HangmanWord('MORANGO', 'Fruta vermelha com sementinhas'),
      ],
    ),

    // NÍVEL 7 - Ninja (6-7 letras, geografia)
    const HangmanLevelData(
      level: 7,
      name: 'Ninja',
      maxErrors: 6,
      threeStarErrors: 1,
      twoStarErrors: 3,
      words: [
        HangmanWord('OCEANO', 'Grande massa de água salgada'),
        HangmanWord('VULCÃO', 'Montanha que cospe lava'),
        HangmanWord('DESERTO', 'Muita areia e calor'),
        HangmanWord('CAVERNA', 'Buraco dentro da montanha'),
        HangmanWord('GELEIRA', 'Rio de gelo gigante'),
        HangmanWord('CASCATA', 'Água que cai de altura'),
        HangmanWord('LAGOA', 'Lago pequeno'),
        HangmanWord('CRATERA', 'Buraco feito por vulcão'),
        HangmanWord('SAVANA', 'Planície africana com animais'),
        HangmanWord('PANTANAL', 'Bioma alagado do Brasil'),
      ],
    ),

    // NÍVEL 8 - Gênio (7-8 letras, ciência)
    const HangmanLevelData(
      level: 8,
      name: 'Gênio',
      maxErrors: 6,
      threeStarErrors: 1,
      twoStarErrors: 2,
      words: [
        HangmanWord('PLANETA', 'Gira ao redor do sol'),
        HangmanWord('ESTRELA', 'Brilha no céu à noite'),
        HangmanWord('FOGUETE', 'Vai pro espaço'),
        HangmanWord('UNIVERSO', 'Tudo que existe'),
        HangmanWord('COMETA', 'Bola de gelo que cruza o céu'),
        HangmanWord('ECLIPSE', 'Lua tampa o sol'),
        HangmanWord('ÁTOMO', 'Menor parte da matéria'),
        HangmanWord('OXIGÊNIO', 'Gás que respiramos'),
        HangmanWord('SATÉLITE', 'Gira ao redor de um planeta'),
        HangmanWord('GALÁXIA', 'Conjunto de bilhões de estrelas'),
      ],
    ),

    // NÍVEL 9 - Expert (8-9 letras, profissões)
    const HangmanLevelData(
      level: 9,
      name: 'Expert',
      maxErrors: 5,
      threeStarErrors: 1,
      twoStarErrors: 2,
      words: [
        HangmanWord('PROFESSOR', 'Ensina na escola'),
        HangmanWord('BOMBEIRO', 'Apaga incêndios'),
        HangmanWord('ASTRONAUTA', 'Viaja ao espaço'),
        HangmanWord('ENGENHEIRO', 'Constrói prédios e pontes'),
        HangmanWord('DENTISTA', 'Cuida dos dentes'),
        HangmanWord('COZINHEIRO', 'Prepara comida no restaurante'),
        HangmanWord('MOTORISTA', 'Dirige veículos'),
        HangmanWord('JORNALISTA', 'Escreve notícias'),
        HangmanWord('CIENTISTA', 'Faz pesquisas e descobre coisas'),
        HangmanWord('ADVOGADO', 'Defende pessoas no tribunal'),
      ],
    ),

    // NÍVEL 10 - Mestre (9+ letras, palavras difíceis)
    const HangmanLevelData(
      level: 10,
      name: 'Mestre',
      maxErrors: 5,
      threeStarErrors: 0,
      twoStarErrors: 2,
      words: [
        HangmanWord('BORBOLETA', 'Inseto com asas coloridas'),
        HangmanWord('HELICÓPTERO', 'Voa com hélices no topo'),
        HangmanWord('PARALELEPÍPEDO', 'Pedra usada nas ruas antigas'),
        HangmanWord('RINOCERONTE', 'Animal com chifre no nariz'),
        HangmanWord('HIPOPÓTAMO', 'Animal pesado que vive no rio'),
        HangmanWord('DINOSSAURO', 'Animal extinto gigante'),
        HangmanWord('ESTETOSCÓPIO', 'Médico usa pra ouvir o coração'),
        HangmanWord('REFRIGERADOR', 'Eletrodoméstico que gela comida'),
        HangmanWord('TRANSGÊNICO', 'Alimento modificado em laboratório'),
        HangmanWord('ORNITORRINCO', 'Mamífero com bico de pato'),
      ],
    ),
  ];
}
