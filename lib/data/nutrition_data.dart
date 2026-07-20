import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_colors.dart';

/// All learning content for the six nutrition colors.
/// Order matters: it defines the unlock progression Red -> Purple.
const List<NutritionColorInfo> kColors = [
  // ─────────────────────────── RED ───────────────────────────
  NutritionColorInfo(
    id: 'red',
    name: 'Đỏ',
    nameEn: 'Red',
    compound: 'Lycopene',
    benefit: 'Tốt cho tim mạch',
    benefitEn: 'Heart',
    emoji: '🍅',
    icons: ['🍅', '🥩'],
    color: AppColors.red,
    colorLight: AppColors.redLight,
    onColor: AppColors.white,
    description:
        'Lycopene là sắc tố tạo màu đỏ cho cà chua và dưa hấu. Nó là một chất '
        'chống oxy hóa mạnh, giúp bảo vệ tim mạch và có thể giảm nguy cơ mắc '
        'một số loại ung thư. Ăn thực phẩm màu đỏ mỗi ngày giúp trái tim của '
        'bạn luôn khỏe mạnh.',
    descriptionEn:
        'Lycopene is the pigment that gives tomatoes and watermelon their red '
        'color. It is a powerful antioxidant that helps protect the heart and '
        'may lower the risk of some types of cancer. Eating red foods every '
        'day helps keep your heart healthy.',
    foods: [
      FoodItem('🍅', 'Cà chua', 'Tomato'),
      FoodItem('🍉', 'Dưa hấu', 'Watermelon'),
      FoodItem('🍓', 'Dâu tây', 'Strawberry'),
      FoodItem('🥩', 'Thịt bò', 'Beef'),
      FoodItem('🦐', 'Tôm', 'Shrimp'),
      FoodItem('🌶️', 'Ớt đỏ', 'Red pepper'),
    ],
    funFact:
        'Cà chua nấu chín giải phóng nhiều lycopene hơn cà chua sống — nên một '
        'bát canh cà chua rất bổ dưỡng!',
    funFactEn:
        'Cooked tomatoes release more lycopene than raw ones — so a bowl of '
        'tomato soup is very nutritious!',
    quiz: [
      QuizQuestion(
        question: 'Chất nào tạo màu đỏ cho cà chua?',
        questionEn: 'Which compound gives tomatoes their red color?',
        options: ['Chlorophyll', 'Lycopene', 'Anthocyanin', 'Beta-caroten'],
        correctIndex: 1,
        optionsEn: ['Chlorophyll', 'Lycopene', 'Anthocyanin', 'Beta-carotene'],
      ),
      QuizQuestion(
        question: 'Lycopene đặc biệt tốt cho cơ quan nào?',
        questionEn: 'Lycopene is especially good for which organ?',
        options: ['Xương', 'Tim mạch', 'Tóc', 'Móng tay'],
        correctIndex: 1,
        optionsEn: ['Bones', 'Heart', 'Hair', 'Nails'],
      ),
      QuizQuestion(
        question: 'Thực phẩm nào giàu lycopene?',
        questionEn: 'Which food is rich in lycopene?',
        options: ['Cà rốt', 'Dưa hấu', 'Chuối', 'Bông cải xanh'],
        correctIndex: 1,
        optionsEn: ['Carrot', 'Watermelon', 'Banana', 'Broccoli'],
      ),
      QuizQuestion(
        question: 'Cách chế biến nào giúp giải phóng nhiều lycopene hơn?',
        questionEn: 'Which method releases more lycopene?',
        options: ['Ăn sống', 'Nấu chín', 'Đông lạnh', 'Sấy khô'],
        correctIndex: 1,
        optionsEn: ['Eating raw', 'Cooking', 'Freezing', 'Drying'],
      ),
      QuizQuestion(
        question: 'Lycopene thuộc nhóm chất nào?',
        questionEn: 'Lycopene belongs to which group?',
        options: ['Chất đạm', 'Chất chống oxy hóa', 'Chất xơ', 'Đường'],
        correctIndex: 1,
        optionsEn: ['Protein', 'Antioxidant', 'Fiber', 'Sugar'],
      ),
    ],
  ),

  // ────────────────────────── ORANGE ─────────────────────────
  NutritionColorInfo(
    id: 'orange',
    name: 'Cam',
    nameEn: 'Orange',
    compound: 'Beta-caroten',
    benefit: 'Sáng mắt',
    benefitEn: 'Vision',
    emoji: '🥕',
    icons: ['🥕', '🍣'],
    color: AppColors.orange,
    colorLight: AppColors.orangeLight,
    onColor: AppColors.white,
    description:
        'Beta-caroten là sắc tố tạo màu cam cho cà rốt và bí đỏ. Khi vào cơ '
        'thể, nó được chuyển hóa thành vitamin A — dưỡng chất rất quan trọng '
        'giúp đôi mắt sáng khỏe và tăng cường thị lực, đặc biệt là khả năng '
        'nhìn trong điều kiện thiếu sáng.',
    descriptionEn:
        'Beta-carotene is the pigment that gives carrots and pumpkin their '
        'orange color. Once in the body, it is converted into vitamin A — a '
        'nutrient that is essential for keeping the eyes bright and healthy '
        'and for boosting vision, especially the ability to see in low light.',
    foods: [
      FoodItem('🥕', 'Cà rốt', 'Carrot'),
      FoodItem('🎃', 'Bí đỏ', 'Pumpkin'),
      FoodItem('🍣', 'Cá hồi', 'Salmon'),
      FoodItem('🥚', 'Lòng đỏ trứng', 'Egg yolk'),
      FoodItem('🍠', 'Khoai lang', 'Sweet potato'),
      FoodItem('🥭', 'Xoài', 'Mango'),
    ],
    funFact:
        'Cơ thể chỉ chuyển hóa beta-caroten thành vitamin A khi cần, nên ăn '
        'nhiều cà rốt sẽ không gây thừa vitamin A.',
    funFactEn:
        'The body only converts beta-carotene into vitamin A when it needs to, '
        'so eating lots of carrots will not cause a vitamin A overdose.',
    quiz: [
      QuizQuestion(
        question: 'Beta-caroten được cơ thể chuyển hóa thành vitamin nào?',
        questionEn: 'Beta-carotene is converted into which vitamin?',
        options: ['Vitamin C', 'Vitamin A', 'Vitamin D', 'Vitamin K'],
        correctIndex: 1,
        optionsEn: ['Vitamin C', 'Vitamin A', 'Vitamin D', 'Vitamin K'],
      ),
      QuizQuestion(
        question: 'Beta-caroten đặc biệt tốt cho điều gì?',
        questionEn: 'Beta-carotene is especially good for what?',
        options: ['Thị lực', 'Thính giác', 'Xương', 'Cơ bắp'],
        correctIndex: 0,
        optionsEn: ['Vision', 'Hearing', 'Bones', 'Muscles'],
      ),
      QuizQuestion(
        question: 'Thực phẩm nào giàu beta-caroten?',
        questionEn: 'Which food is rich in beta-carotene?',
        options: ['Cà rốt', 'Việt quất', 'Chanh', 'Cải bó xôi'],
        correctIndex: 0,
        optionsEn: ['Carrot', 'Blueberry', 'Lemon', 'Spinach'],
      ),
      QuizQuestion(
        question: 'Màu cam của cà rốt là do sắc tố nào?',
        questionEn: 'The orange color of carrots comes from which pigment?',
        options: ['Anthocyanin', 'Beta-caroten', 'Chlorophyll', 'Lycopene'],
        correctIndex: 1,
        optionsEn: ['Anthocyanin', 'Beta-carotene', 'Chlorophyll', 'Lycopene'],
      ),
      QuizQuestion(
        question: 'Vitamin A giúp ích gì cho mắt vào ban đêm?',
        questionEn: 'How does vitamin A help the eyes at night?',
        options: ['Ngủ ngon hơn', 'Nhìn rõ trong tối', 'Mọc mi dài', 'Hết cận'],
        correctIndex: 1,
        optionsEn: [
          'Sleep better',
          'See clearly in the dark',
          'Grow longer lashes',
          'Cure short-sightedness',
        ],
      ),
    ],
  ),

  // ────────────────────────── YELLOW ─────────────────────────
  NutritionColorInfo(
    id: 'yellow',
    name: 'Vàng',
    nameEn: 'Yellow',
    compound: 'Vitamin C',
    benefit: 'Tăng đề kháng',
    benefitEn: 'Immunity',
    emoji: '🌽',
    icons: ['🌽', '🧀'],
    color: AppColors.yellow,
    colorLight: AppColors.yellowDeep,
    onColor: AppColors.yellowInk,
    description:
        'Nhiều thực phẩm màu vàng như ngô, dứa và chanh rất giàu vitamin C. '
        'Vitamin C giúp tăng cường hệ miễn dịch, chống lại cảm cúm, hỗ trợ cơ '
        'thể hấp thu sắt và tham gia sản xuất collagen cho làn da khỏe mạnh.',
    descriptionEn:
        'Many yellow foods such as corn, pineapple and lemon are rich in '
        'vitamin C. Vitamin C helps strengthen the immune system, fight off '
        'colds and flu, helps the body absorb iron and takes part in producing '
        'collagen for healthy skin.',
    foods: [
      FoodItem('🌽', 'Ngô', 'Corn'),
      FoodItem('🍍', 'Dứa', 'Pineapple'),
      FoodItem('🧀', 'Phô mai', 'Cheese'),
      FoodItem('🥚', 'Trứng', 'Egg'),
      FoodItem('🍋', 'Chanh', 'Lemon'),
      FoodItem('🍌', 'Chuối', 'Banana'),
    ],
    funFact:
        'Vitamin C giúp cơ thể hấp thu sắt tốt hơn — vắt chút chanh vào món ăn '
        'giàu sắt là một mẹo nhỏ rất hữu ích!',
    funFactEn:
        'Vitamin C helps the body absorb iron better — squeezing a little '
        'lemon over an iron-rich dish is a handy little tip!',
    quiz: [
      QuizQuestion(
        question: 'Thực phẩm màu vàng có múi thường giàu vitamin nào?',
        questionEn: 'Yellow citrus foods are rich in which vitamin?',
        options: ['Vitamin C', 'Vitamin B12', 'Vitamin D', 'Vitamin E'],
        correctIndex: 0,
        optionsEn: ['Vitamin C', 'Vitamin B12', 'Vitamin D', 'Vitamin E'],
      ),
      QuizQuestion(
        question: 'Vitamin C giúp tăng cường điều gì?',
        questionEn: 'Vitamin C helps strengthen what?',
        options: ['Đề kháng', 'Thị lực', 'Chiều cao', 'Trí nhớ'],
        correctIndex: 0,
        optionsEn: ['Immunity', 'Vision', 'Height', 'Memory'],
      ),
      QuizQuestion(
        question: 'Vitamin C hỗ trợ cơ thể hấp thu khoáng chất nào?',
        questionEn: 'Vitamin C helps absorb which mineral?',
        options: ['Canxi', 'Sắt', 'Kẽm', 'Magie'],
        correctIndex: 1,
        optionsEn: ['Calcium', 'Iron', 'Zinc', 'Magnesium'],
      ),
      QuizQuestion(
        question: 'Thực phẩm nào giàu vitamin C?',
        questionEn: 'Which food is rich in vitamin C?',
        options: ['Thịt bò', 'Chanh', 'Cơm trắng', 'Bơ'],
        correctIndex: 1,
        optionsEn: ['Beef', 'Lemon', 'White rice', 'Avocado'],
      ),
      QuizQuestion(
        question: 'Vitamin C tham gia sản xuất chất nào cho da?',
        questionEn: 'Vitamin C helps produce what for the skin?',
        options: ['Keratin', 'Collagen', 'Melanin', 'Insulin'],
        correctIndex: 1,
        optionsEn: ['Keratin', 'Collagen', 'Melanin', 'Insulin'],
      ),
    ],
  ),

  // ─────────────────────────── GREEN ─────────────────────────
  NutritionColorInfo(
    id: 'green',
    name: 'Xanh lá',
    nameEn: 'Green',
    compound: 'Chlorophyll',
    benefit: 'Thải độc',
    benefitEn: 'Detox',
    emoji: '🥦',
    icons: ['🥦', '🥑'],
    color: AppColors.green,
    colorLight: AppColors.greenLight,
    onColor: AppColors.white,
    description:
        'Chlorophyll (diệp lục) là sắc tố tạo màu xanh cho rau lá. Rau xanh '
        'đậm còn rất giàu sắt, folate và chất xơ, giúp cơ thể thải độc, hỗ trợ '
        'tiêu hóa và tạo máu. Ăn nhiều rau xanh mỗi ngày giúp cơ thể nhẹ nhàng '
        'và tràn đầy năng lượng.',
    descriptionEn:
        'Chlorophyll is the pigment that gives leafy vegetables their green '
        'color. Dark leafy greens are also rich in iron, folate and fiber, '
        'helping the body detox, supporting digestion and producing blood. '
        'Eating plenty of greens every day keeps the body light and full of '
        'energy.',
    foods: [
      FoodItem('🥦', 'Bông cải', 'Broccoli'),
      FoodItem('🥬', 'Cải bó xôi', 'Spinach'),
      FoodItem('🥑', 'Bơ', 'Avocado'),
      FoodItem('🥝', 'Kiwi', 'Kiwi'),
    ],
    funFact:
        'Chlorophyll giúp cây xanh hấp thụ ánh sáng để quang hợp — chính quá '
        'trình này tạo ra oxy cho chúng ta thở.',
    funFactEn:
        'Chlorophyll helps green plants absorb light for photosynthesis — and '
        'it is this very process that produces the oxygen we breathe.',
    quiz: [
      QuizQuestion(
        question: 'Sắc tố nào tạo màu xanh lá cho rau?',
        questionEn: 'Which pigment gives vegetables their green color?',
        options: ['Chlorophyll', 'Lycopene', 'Anthocyanin', 'Beta-caroten'],
        correctIndex: 0,
        optionsEn: ['Chlorophyll', 'Lycopene', 'Anthocyanin', 'Beta-carotene'],
      ),
      QuizQuestion(
        question: 'Rau xanh lá đậm thường giàu khoáng chất nào?',
        questionEn: 'Dark leafy greens are rich in which mineral?',
        options: ['Sắt', 'Natri', 'Đường', 'Chất béo'],
        correctIndex: 0,
        optionsEn: ['Iron', 'Sodium', 'Sugar', 'Fat'],
      ),
      QuizQuestion(
        question: 'Nhóm thực phẩm màu xanh lá hỗ trợ chức năng nào?',
        questionEn: 'Green foods support which function?',
        options: ['Thải độc cơ thể', 'Tăng đường huyết', 'Gây buồn ngủ', 'Làm khô da'],
        correctIndex: 0,
        optionsEn: [
          'Detoxifying the body',
          'Raising blood sugar',
          'Causing drowsiness',
          'Drying out the skin',
        ],
      ),
      QuizQuestion(
        question: 'Thực phẩm nào thuộc nhóm màu xanh lá?',
        questionEn: 'Which food belongs to the green group?',
        options: ['Cà rốt', 'Bông cải xanh', 'Việt quất', 'Ngô'],
        correctIndex: 1,
        optionsEn: ['Carrot', 'Broccoli', 'Blueberry', 'Corn'],
      ),
      QuizQuestion(
        question: 'Chlorophyll giúp cây thực hiện quá trình nào?',
        questionEn: 'Chlorophyll helps plants carry out which process?',
        options: ['Hô hấp', 'Quang hợp', 'Lên men', 'Đông đặc'],
        correctIndex: 1,
        optionsEn: ['Respiration', 'Photosynthesis', 'Fermentation', 'Solidifying'],
      ),
    ],
  ),

  // ─────────────────────────── BLUE ──────────────────────────
  NutritionColorInfo(
    id: 'blue',
    name: 'Xanh dương',
    nameEn: 'Blue',
    compound: 'Anthocyanin',
    benefit: 'Tốt cho não',
    benefitEn: 'Brain',
    emoji: '🫐',
    icons: ['🫐', '🐟'],
    color: AppColors.blue,
    colorLight: Color(0xFF77BEFF),
    onColor: AppColors.white,
    description:
        'Anthocyanin là sắc tố tạo màu xanh dương và tím cho việt quất, nho. '
        'Đây là chất chống oxy hóa mạnh, đặc biệt tốt cho não bộ, giúp cải '
        'thiện trí nhớ và bảo vệ tế bào thần kinh khỏi tổn thương.',
    descriptionEn:
        'Anthocyanin is the pigment that gives blueberries and grapes their '
        'blue and purple color. It is a powerful antioxidant that is '
        'especially good for the brain, helping to improve memory and protect '
        'nerve cells from damage.',
    foods: [
      FoodItem('🫐', 'Việt quất', 'Blueberry'),
      FoodItem('🍇', 'Nho', 'Grapes'),
      FoodItem('🫐', 'Mâm xôi', 'Raspberry'),
      FoodItem('🍈', 'Mận', 'Plum'),
    ],
    funFact:
        'Việt quất được mệnh danh là "siêu thực phẩm cho não" nhờ hàm lượng '
        'anthocyanin rất cao.',
    funFactEn:
        'Blueberries are known as a "superfood for the brain" thanks to their '
        'very high anthocyanin content.',
    quiz: [
      QuizQuestion(
        question: 'Sắc tố nào tạo màu xanh dương cho việt quất?',
        questionEn: 'Which pigment gives blueberries their blue color?',
        options: ['Anthocyanin', 'Chlorophyll', 'Lycopene', 'Vitamin C'],
        correctIndex: 0,
        optionsEn: ['Anthocyanin', 'Chlorophyll', 'Lycopene', 'Vitamin C'],
      ),
      QuizQuestion(
        question: 'Anthocyanin đặc biệt hỗ trợ cơ quan nào?',
        questionEn: 'Anthocyanin especially supports which organ?',
        options: ['Não bộ', 'Dạ dày', 'Da', 'Xương'],
        correctIndex: 0,
        optionsEn: ['Brain', 'Stomach', 'Skin', 'Bones'],
      ),
      QuizQuestion(
        question: 'Thực phẩm nào giàu anthocyanin?',
        questionEn: 'Which food is rich in anthocyanin?',
        options: ['Việt quất', 'Cà rốt', 'Ngô', 'Chuối'],
        correctIndex: 0,
        optionsEn: ['Blueberry', 'Carrot', 'Corn', 'Banana'],
      ),
      QuizQuestion(
        question: 'Anthocyanin là loại chất gì?',
        questionEn: 'Anthocyanin is what type of substance?',
        options: ['Chất béo', 'Chất chống oxy hóa', 'Chất đạm', 'Tinh bột'],
        correctIndex: 1,
        optionsEn: ['Fat', 'Antioxidant', 'Protein', 'Starch'],
      ),
      QuizQuestion(
        question: 'Ăn thực phẩm xanh dương/tím có thể giúp cải thiện điều gì?',
        questionEn: 'Eating blue/purple foods can help improve what?',
        options: ['Trí nhớ', 'Chiều cao', 'Màu tóc', 'Giọng nói'],
        correctIndex: 0,
        optionsEn: ['Memory', 'Height', 'Hair color', 'Voice'],
      ),
    ],
  ),

  // ────────────────────────── PURPLE ─────────────────────────
  NutritionColorInfo(
    id: 'purple',
    name: 'Tím',
    nameEn: 'Purple',
    compound: 'Resveratrol',
    benefit: 'Chống lão hóa',
    benefitEn: 'Anti-aging',
    emoji: '🍆',
    icons: ['🍆', '🍇'],
    color: AppColors.purple,
    colorLight: Color(0xFFB794FF),
    onColor: AppColors.white,
    description:
        'Resveratrol là hợp chất nổi bật trong vỏ nho tím, cà tím và các loại '
        'quả mọng sẫm màu. Nó là chất chống oxy hóa giúp chống lão hóa, bảo vệ '
        'tế bào khỏi gốc tự do và hỗ trợ sức khỏe tim mạch.',
    descriptionEn:
        'Resveratrol is a notable compound found in purple grape skin, '
        'eggplant and dark berries. It is an antioxidant that helps fight '
        'ageing, protects cells from free radicals and supports heart health.',
    foods: [
      FoodItem('🍆', 'Cà tím', 'Eggplant'),
      FoodItem('🍇', 'Nho tím', 'Purple grapes'),
      FoodItem('🫐', 'Mâm xôi đen', 'Blackberry'),
      FoodItem('🥬', 'Bắp cải tím', 'Purple cabbage'),
    ],
    funFact:
        'Resveratrol tập trung nhiều nhất ở phần vỏ của quả nho — vì vậy đừng '
        'gọt bỏ vỏ nho nhé!',
    funFactEn:
        'Resveratrol is most concentrated in the skin of grapes — so don\'t '
        'peel your grapes!',
    quiz: [
      QuizQuestion(
        question: 'Hợp chất chống lão hóa nổi bật trong vỏ nho tím là gì?',
        questionEn: 'Which anti-aging compound is found in purple grape skin?',
        options: ['Resveratrol', 'Lycopene', 'Chlorophyll', 'Vitamin A'],
        correctIndex: 0,
        optionsEn: ['Resveratrol', 'Lycopene', 'Chlorophyll', 'Vitamin A'],
      ),
      QuizQuestion(
        question: 'Nhóm thực phẩm màu tím thường gắn với lợi ích nào?',
        questionEn: 'Purple foods are associated with which benefit?',
        options: ['Chống lão hóa', 'Tăng cân', 'Sâu răng', 'Mất ngủ'],
        correctIndex: 0,
        optionsEn: ['Anti-aging', 'Weight gain', 'Tooth decay', 'Insomnia'],
      ),
      QuizQuestion(
        question: 'Thực phẩm nào thuộc nhóm màu tím?',
        questionEn: 'Which food belongs to the purple group?',
        options: ['Cà tím', 'Cà rốt', 'Chanh', 'Bông cải xanh'],
        correctIndex: 0,
        optionsEn: ['Eggplant', 'Carrot', 'Lemon', 'Broccoli'],
      ),
      QuizQuestion(
        question: 'Resveratrol tập trung nhiều nhất ở phần nào của quả nho?',
        questionEn: 'Where is resveratrol most concentrated in grapes?',
        options: ['Hạt', 'Vỏ', 'Cuống', 'Nước ép'],
        correctIndex: 1,
        optionsEn: ['Seeds', 'Skin', 'Stem', 'Juice'],
      ),
      QuizQuestion(
        question: 'Chất chống oxy hóa giúp bảo vệ tế bào khỏi điều gì?',
        questionEn: 'Antioxidants protect cells from what?',
        options: ['Gốc tự do', 'Vitamin', 'Nước', 'Oxy'],
        correctIndex: 0,
        optionsEn: ['Free radicals', 'Vitamins', 'Water', 'Oxygen'],
      ),
    ],
  ),
];

/// Look up a color by its id.
NutritionColorInfo colorById(String id) =>
    kColors.firstWhere((c) => c.id == id);
