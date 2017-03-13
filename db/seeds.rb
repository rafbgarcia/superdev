User.create!(
  {
    email: "monster@gmail.com",
    provider: nil,
    uid: nil,
    name: "Super Monster",
    gender: nil,
    phone: nil,
    facebook_link: nil,
    facebook_avatar: nil,
    avatar_file_name: nil,
    avatar_content_type: nil,
    avatar_file_size: nil,
    avatar_updated_at: nil,
    password: '123456',
  }
)


html = Course.create!(
  name: 'HTML'
)

tags = Lesson.create!(
  course: html,
  name: 'Tags',
  weight: 1,
  free: true
)
basic_structure = Lesson.create!(course: html, name: 'Estrutura básica', weight: 2)

Video.create!(
  url: 'https://www.youtube.com/embed/Mqyrt7RCgsg',
  item: Item.create!(
    lesson: tags,
    title: 'Sobre tags',
    weight: 1,
  ),
)

choice_question = ChoiceQuestion.create!(
  item: Item.create!(
    lesson: tags,
    title: 'O que uma Tag representa no HTML?',
    weight: 2,
    difficulty: 2,
  ),

  alternatives: [
    Alternative.create!(text: 'Um campo de texto', correct: false, explanation: 'Tag '),
    Alternative.create!(text: 'Um tipo de suco', correct: false, explanation: 'Nem é visse...'),
    Alternative.create!(text: 'É o nome que se dá para a representação dos elementos', correct: true),
  ],
)

ChoiceQuestion.create!(
  item: Item.create!(
    lesson: tags,
    title: 'Para que serve a tag <meta>?',
    weight: 3,
    difficulty: 2,
  ),

  alternatives: [
    Alternative.create!(text: 'Para nada', correct: false, explanation: 'A tag meta serve sim para alguma coisa: para configurar os caracteres especiais da página, como acentos e símbolos'),
    Alternative.create!(text: 'Para configurar as tags da página', correct: false, explanation: 'A tag meta serve para configurar os caracteres especiais na página, como acentos e símbolos, e não para configurar as tags'),
    Alternative.create!(text: 'Para configurar os caracteres especiais da página', correct: true),
  ],
)

ChoiceQuestion.create!(
  item: Item.create!(
    lesson: tags,
    title: 'E a tag <title></title>?',
    weight: 4,
    difficulty: 5,
  ),

  alternatives: [
    Alternative.create!(text: 'Para nada', correct: false, explanation: 'A tag meta serve sim para alguma coisa: para configurar os caracteres especiais da página, como acentos e símbolos'),
    Alternative.create!(text: 'Para configurar as tags da página', correct: false, explanation: 'A tag meta serve para configurar os caracteres especiais na página, como acentos e símbolos, e não para configurar as tags'),
    Alternative.create!(text: 'Para configurar os caracteres especiais da página', correct: true),
  ],
)

ChoiceQuestion.create!(
  item: Item.create!(
    lesson: tags,
    title: 'E a tag <title></title>?',
    weight: 5,
    difficulty: 5,
  ),

  alternatives: [
    Alternative.create!(text: 'Para nada', correct: false, explanation: 'A tag meta serve sim para alguma coisa: para configurar os caracteres especiais da página, como acentos e símbolos'),
    Alternative.create!(text: 'Para configurar as tags da página', correct: false, explanation: 'A tag meta serve para configurar os caracteres especiais na página, como acentos e símbolos, e não para configurar as tags'),
    Alternative.create!(text: 'Para configurar os caracteres especiais da página', correct: true),
  ],
)

ChoiceQuestion.create!(
  item: Item.create!(
    lesson: tags,
    title: 'E a tag <title></title>?',
    weight: 6,
    difficulty: 5,
  ),

  alternatives: [
    Alternative.create!(text: 'Para nada', correct: false, explanation: 'A tag meta serve sim para alguma coisa: para configurar os caracteres especiais da página, como acentos e símbolos'),
    Alternative.create!(text: 'Para configurar as tags da página', correct: false, explanation: 'A tag meta serve para configurar os caracteres especiais na página, como acentos e símbolos, e não para configurar as tags'),
    Alternative.create!(text: 'Para configurar os caracteres especiais da página', correct: true),
  ],
)

Video.create!(
  url: 'https://www.youtube.com/embed/Mqyrt7RCgsg',
  item: Item.create!(
    lesson: tags,
    title: 'Estrutura básica',
    weight: 10,
  ),
)

Discussion.create!(
  item: choice_question.item,
  user: User.first,
  title: 'Por que as Tags se chamam tags?',
  text: 'Só por curiosidade mesmo...',
)

Discussion.create!(
  item: choice_question.item,
  user: User.first,
  title: 'Não entendi o que a tag <meta> faz',
  text: 'Pode explicar por favor?',
  resolved: true,
)






Video.create!(
  url: 'https://www.youtube.com/embed/Mqyrt7RCgsg',
  item: Item.create!(
    lesson: basic_structure,
    title: 'Estrutura básica',
    weight: 1,
  ),
)

ChoiceQuestion.create!(
  item: Item.create!(
    lesson: basic_structure,
    title: 'E a tag <title></title>?',
    weight: 2,
    difficulty: 5,
  ),

  alternatives: [
    Alternative.create!(text: 'Para nada', correct: false, explanation: 'A tag meta serve sim para alguma coisa: para configurar os caracteres especiais da página, como acentos e símbolos'),
    Alternative.create!(text: 'Para configurar as tags da página', correct: false, explanation: 'A tag meta serve para configurar os caracteres especiais na página, como acentos e símbolos, e não para configurar as tags'),
    Alternative.create!(text: 'Para configurar os caracteres especiais da página', correct: true),
  ],
)
