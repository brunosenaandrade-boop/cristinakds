// ============================================================
// CONFIGURAÇÃO DOS 10 NÍVEIS DO QUIZ - CristinaKids
// ============================================================
// Quer mudar perguntas, respostas ou dificuldade?
// Mude AQUI!
// ============================================================

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex; // Índice da resposta correta (0-3)

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class QuizLevelData {
  final int level;
  final String name;
  final String category;
  final List<QuizQuestion> questions;
  final int threeStarCorrect; // Mínimo de acertos pra 3 estrelas
  final int twoStarCorrect; // Mínimo de acertos pra 2 estrelas

  const QuizLevelData({
    required this.level,
    required this.name,
    required this.category,
    required this.questions,
    required this.threeStarCorrect,
    required this.twoStarCorrect,
  });
}

class QuizConfig {
  static final List<QuizLevelData> levels = [
    // NÍVEL 1 - Animais Fácil
    const QuizLevelData(
      level: 1,
      name: 'Bebê',
      category: 'Animais',
      threeStarCorrect: 5,
      twoStarCorrect: 3,
      questions: [
        QuizQuestion(
          question: 'Qual animal faz "Au Au"?',
          options: ['Gato', 'Cachorro', 'Pato', 'Vaca'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Qual animal tem listras pretas e brancas?',
          options: ['Leão', 'Elefante', 'Zebra', 'Girafa'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual animal vive na água?',
          options: ['Peixe', 'Cachorro', 'Gato', 'Papagaio'],
          correctIndex: 0,
        ),
        QuizQuestion(
          question: 'Qual animal bota ovos?',
          options: ['Cachorro', 'Gato', 'Galinha', 'Cavalo'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual é o maior animal do mundo?',
          options: ['Elefante', 'Baleia Azul', 'Girafa', 'Tubarão'],
          correctIndex: 1,
        ),
      ],
    ),

    // NÍVEL 2 - Cores e Formas
    const QuizLevelData(
      level: 2,
      name: 'Iniciante',
      category: 'Cores e Formas',
      threeStarCorrect: 5,
      twoStarCorrect: 3,
      questions: [
        QuizQuestion(
          question: 'Quantos lados tem um triângulo?',
          options: ['2', '3', '4', '5'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Qual cor formamos ao misturar azul e amarelo?',
          options: ['Vermelho', 'Roxo', 'Verde', 'Laranja'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Quantos lados tem um quadrado?',
          options: ['3', '4', '5', '6'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Qual a cor do sol?',
          options: ['Azul', 'Verde', 'Amarelo', 'Vermelho'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Que forma tem uma bola?',
          options: ['Quadrado', 'Triângulo', 'Retângulo', 'Círculo'],
          correctIndex: 3,
        ),
      ],
    ),

    // NÍVEL 3 - Frutas e Alimentos
    const QuizLevelData(
      level: 3,
      name: 'Curioso',
      category: 'Frutas e Alimentos',
      threeStarCorrect: 5,
      twoStarCorrect: 3,
      questions: [
        QuizQuestion(
          question: 'Qual fruta é amarela e curva?',
          options: ['Maçã', 'Banana', 'Uva', 'Morango'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'De que é feito o queijo?',
          options: ['Água', 'Farinha', 'Leite', 'Ovos'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual fruta tem uma coroa?',
          options: ['Banana', 'Uva', 'Abacaxi', 'Pera'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual alimento vem da galinha?',
          options: ['Leite', 'Ovo', 'Queijo', 'Pão'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Qual fruta é vermelha e pequena?',
          options: ['Melancia', 'Abacaxi', 'Morango', 'Banana'],
          correctIndex: 2,
        ),
      ],
    ),

    // NÍVEL 4 - Corpo Humano
    const QuizLevelData(
      level: 4,
      name: 'Esperto',
      category: 'Corpo Humano',
      threeStarCorrect: 5,
      twoStarCorrect: 3,
      questions: [
        QuizQuestion(
          question: 'Quantos dedos temos nas duas mãos?',
          options: ['5', '8', '10', '12'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual órgão usamos para respirar?',
          options: ['Coração', 'Pulmão', 'Fígado', 'Estômago'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Onde fica o coração no corpo?',
          options: ['Na cabeça', 'Na barriga', 'No peito', 'No braço'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Quantos sentidos o ser humano tem?',
          options: ['3', '4', '5', '6'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual parte do corpo usamos para pensar?',
          options: ['Coração', 'Cérebro', 'Pulmão', 'Mão'],
          correctIndex: 1,
        ),
      ],
    ),

    // NÍVEL 5 - Natureza
    const QuizLevelData(
      level: 5,
      name: 'Inteligente',
      category: 'Natureza',
      threeStarCorrect: 6,
      twoStarCorrect: 4,
      questions: [
        QuizQuestion(
          question: 'Qual o planeta em que vivemos?',
          options: ['Marte', 'Júpiter', 'Terra', 'Vênus'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'O que as plantas precisam para crescer?',
          options: ['Chocolate', 'Água e sol', 'Areia', 'Pedras'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Qual estação do ano é mais fria?',
          options: ['Verão', 'Primavera', 'Outono', 'Inverno'],
          correctIndex: 3,
        ),
        QuizQuestion(
          question: 'De onde vem a chuva?',
          options: ['Do chão', 'Das nuvens', 'Do mar', 'Das árvores'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'O que o arco-íris tem?',
          options: ['2 cores', '5 cores', '7 cores', '10 cores'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual é o maior oceano do mundo?',
          options: ['Atlântico', 'Índico', 'Ártico', 'Pacífico'],
          correctIndex: 3,
        ),
      ],
    ),

    // NÍVEL 6 - Geografia
    const QuizLevelData(
      level: 6,
      name: 'Desafiador',
      category: 'Geografia',
      threeStarCorrect: 6,
      twoStarCorrect: 4,
      questions: [
        QuizQuestion(
          question: 'Qual é o maior país do mundo?',
          options: ['Brasil', 'China', 'Rússia', 'Estados Unidos'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Em que continente fica o Brasil?',
          options: ['Europa', 'África', 'América do Sul', 'Ásia'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual é o rio mais longo do mundo?',
          options: ['Rio Nilo', 'Rio Amazonas', 'Rio Tietê', 'Rio São Francisco'],
          correctIndex: 0,
        ),
        QuizQuestion(
          question: 'Qual é a capital do Brasil?',
          options: ['São Paulo', 'Rio de Janeiro', 'Brasília', 'Salvador'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Quantos continentes existem?',
          options: ['4', '5', '6', '7'],
          correctIndex: 3,
        ),
        QuizQuestion(
          question: 'Onde fica a Torre Eiffel?',
          options: ['Londres', 'Roma', 'Paris', 'Berlim'],
          correctIndex: 2,
        ),
      ],
    ),

    // NÍVEL 7 - Ciências
    const QuizLevelData(
      level: 7,
      name: 'Ninja',
      category: 'Ciências',
      threeStarCorrect: 7,
      twoStarCorrect: 5,
      questions: [
        QuizQuestion(
          question: 'Qual gás respiramos?',
          options: ['Nitrogênio', 'Oxigênio', 'Hidrogênio', 'Hélio'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Quantos planetas tem o Sistema Solar?',
          options: ['6', '7', '8', '9'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'O que os dinossauros são?',
          options: ['Mamíferos', 'Répteis', 'Aves', 'Peixes'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Qual é o planeta mais perto do Sol?',
          options: ['Vênus', 'Terra', 'Mercúrio', 'Marte'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'A água ferve a quantos graus?',
          options: ['50°C', '75°C', '100°C', '200°C'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual é o maior osso do corpo humano?',
          options: ['Úmero', 'Tíbia', 'Fêmur', 'Costela'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'O que a Lua faz ao redor da Terra?',
          options: ['Nada', 'Gira', 'Para', 'Pisca'],
          correctIndex: 1,
        ),
      ],
    ),

    // NÍVEL 8 - História
    const QuizLevelData(
      level: 8,
      name: 'Gênio',
      category: 'História',
      threeStarCorrect: 7,
      twoStarCorrect: 5,
      questions: [
        QuizQuestion(
          question: 'Quem descobriu o Brasil?',
          options: ['Colombo', 'Pedro Álvares Cabral', 'Dom Pedro I', 'Tiradentes'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Em que ano o Brasil foi descoberto?',
          options: ['1400', '1500', '1600', '1700'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Qual o nome dos povos nativos do Brasil?',
          options: ['Romanos', 'Vikings', 'Indígenas', 'Egípcios'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Quem proclamou a Independência do Brasil?',
          options: ['Tiradentes', 'Dom Pedro I', 'Dom Pedro II', 'Getúlio Vargas'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'O que são as pirâmides do Egito?',
          options: ['Casas', 'Escolas', 'Túmulos', 'Igrejas'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual civilização construiu o Coliseu?',
          options: ['Grega', 'Egípcia', 'Romana', 'Chinesa'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Quando o homem foi à Lua pela primeira vez?',
          options: ['1959', '1969', '1979', '1989'],
          correctIndex: 1,
        ),
      ],
    ),

    // NÍVEL 9 - Ciências Avançado
    const QuizLevelData(
      level: 9,
      name: 'Expert',
      category: 'Ciências Avançado',
      threeStarCorrect: 7,
      twoStarCorrect: 5,
      questions: [
        QuizQuestion(
          question: 'Qual é a fórmula da água?',
          options: ['CO2', 'H2O', 'O2', 'NaCl'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'O que é a fotossíntese?',
          options: ['Tirar foto', 'Planta fazendo comida com luz', 'Tipo de célula', 'Reação do fogo'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Qual planeta é conhecido como Planeta Vermelho?',
          options: ['Júpiter', 'Saturno', 'Marte', 'Vênus'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'O que é a gravidade?',
          options: ['Força que puxa pra cima', 'Força que puxa pra baixo', 'Tipo de gás', 'Tipo de luz'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Quantos estados da matéria existem?',
          options: ['2', '3', '4', '5'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'O que é um vulcão?',
          options: ['Rio de fogo', 'Montanha que expele lava', 'Tipo de nuvem', 'Terremoto'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Qual a velocidade da luz?',
          options: ['1.000 km/s', '100.000 km/s', '300.000 km/s', '500.000 km/s'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Que tipo de animal é a baleia?',
          options: ['Peixe', 'Réptil', 'Mamífero', 'Anfíbio'],
          correctIndex: 2,
        ),
      ],
    ),

    // NÍVEL 10 - Mestre (Mistura de tudo)
    const QuizLevelData(
      level: 10,
      name: 'Mestre',
      category: 'Conhecimentos Gerais',
      threeStarCorrect: 8,
      twoStarCorrect: 6,
      questions: [
        QuizQuestion(
          question: 'Qual é o animal terrestre mais rápido?',
          options: ['Leão', 'Cavalo', 'Guepardo', 'Avestruz'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Quantos zeros tem um milhão?',
          options: ['4', '5', '6', '7'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual instrumento tem 88 teclas?',
          options: ['Guitarra', 'Violão', 'Piano', 'Flauta'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual o maior deserto do mundo?',
          options: ['Sahara', 'Gobi', 'Antártida', 'Atacama'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual metal é líquido em temperatura ambiente?',
          options: ['Ferro', 'Ouro', 'Mercúrio', 'Prata'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'O DNA fica dentro de qual estrutura?',
          options: ['Coração', 'Célula', 'Osso', 'Músculo'],
          correctIndex: 1,
        ),
        QuizQuestion(
          question: 'Qual país inventou a pizza?',
          options: ['França', 'Espanha', 'Itália', 'Grécia'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Quantas horas tem um dia?',
          options: ['12', '20', '24', '30'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'Qual é a montanha mais alta do mundo?',
          options: ['Andes', 'Kilimanjaro', 'Monte Everest', 'Alpes'],
          correctIndex: 2,
        ),
        QuizQuestion(
          question: 'O que é o Sol?',
          options: ['Um planeta', 'Uma estrela', 'Uma lua', 'Um cometa'],
          correctIndex: 1,
        ),
      ],
    ),
  ];
}
