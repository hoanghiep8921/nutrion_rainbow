import '../models/food_quiz.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';

/// Quizzes about everyday foods beyond fruit & vegetables — meat, fish,
/// dairy, grains and plant proteins.
const List<FoodQuizTopic> kFoodQuizzes = [
  // ───────────────────────── Meat & poultry ─────────────────────────
  FoodQuizTopic(
    id: 'meat',
    title: 'Thịt & Gia cầm',
    titleEn: 'Meat & Poultry',
    emoji: '🍗',
    color: AppColors.red,
    blurb: 'Thịt bò, heo, gà — nguồn đạm và sắt.',
    blurbEn: 'Beef, pork, chicken — a source of protein and iron.',
    quiz: [
      QuizQuestion(
        question: 'Thịt là nguồn dồi dào chất dinh dưỡng nào?',
        questionEn: 'Meat is richest in which nutrient?',
        options: ['Chất xơ', 'Chất đạm (protein)', 'Vitamin C', 'Tinh bột'],
        correctIndex: 1,
        optionsEn: ['Fiber', 'Protein', 'Vitamin C', 'Starch'],
      ),
      QuizQuestion(
        question: 'Vitamin nào có nhiều trong thịt đỏ mà thực vật hầu như '
            'không có?',
        questionEn: 'Which vitamin is abundant in red meat but scarce in '
            'plants?',
        options: ['Vitamin C', 'Vitamin B12', 'Vitamin D', 'Vitamin K'],
        correctIndex: 1,
        optionsEn: ['Vitamin C', 'Vitamin B12', 'Vitamin D', 'Vitamin K'],
      ),
      QuizQuestion(
        question: 'Sắt dạng heme trong thịt đỏ có ưu điểm gì?',
        questionEn: 'What is an advantage of heme iron in red meat?',
        options: [
          'Cơ thể hấp thu tốt hơn sắt từ thực vật',
          'Không thể hấp thu được',
          'Chỉ có trong rau xanh',
          'Là một loại đường',
        ],
        correctIndex: 0,
        optionsEn: [
          'The body absorbs it better than plant iron',
          'It cannot be absorbed',
          'It is only found in greens',
          'It is a type of sugar',
        ],
      ),
      QuizQuestion(
        question: 'Để giảm chất béo bão hòa, nên chọn phần gà nào?',
        questionEn: 'To cut saturated fat, which chicken part is best?',
        options: ['Da gà chiên', 'Ức gà bỏ da', 'Cánh chiên giòn', 'Mỡ gà'],
        correctIndex: 1,
        optionsEn: [
          'Fried chicken skin',
          'Skinless chicken breast',
          'Crispy fried wings',
          'Chicken fat',
        ],
      ),
      QuizQuestion(
        question: 'Cách chế biến thịt nào thường lành mạnh hơn?',
        questionEn: 'Which cooking method is generally healthier?',
        options: [
          'Chiên ngập dầu',
          'Xông khói nhiều',
          'Luộc, hấp hoặc nướng',
          'Ướp nhiều muối rồi rán',
        ],
        correctIndex: 2,
        optionsEn: [
          'Deep-frying',
          'Heavy smoking',
          'Boiling, steaming or grilling',
          'Salting heavily then pan-frying',
        ],
      ),
    ],
  ),

  // ───────────────────────── Fish & seafood ─────────────────────────
  FoodQuizTopic(
    id: 'fish',
    title: 'Cá & Hải sản',
    titleEn: 'Fish & Seafood',
    emoji: '🐟',
    color: AppColors.blue,
    blurb: 'Cá béo giàu omega-3, tốt cho tim và não.',
    blurbEn: 'Fatty fish are rich in omega-3, good for the heart and brain.',
    quiz: [
      QuizQuestion(
        question: 'Cá béo (cá hồi, cá thu) nổi bật nhờ chất béo nào?',
        questionEn: 'Fatty fish (salmon, mackerel) are notable for which fat?',
        options: [
          'Omega-3',
          'Chất béo chuyển hóa (trans fat)',
          'Đường',
          'Cholesterol xấu',
        ],
        correctIndex: 0,
        optionsEn: [
          'Omega-3',
          'Trans fat',
          'Sugar',
          'Bad cholesterol',
        ],
      ),
      QuizQuestion(
        question: 'Omega-3 đặc biệt tốt cho cơ quan nào?',
        questionEn: 'Omega-3 is especially good for which organs?',
        options: ['Răng', 'Tim và não', 'Tóc', 'Móng tay'],
        correctIndex: 1,
        optionsEn: ['Teeth', 'Heart and brain', 'Hair', 'Nails'],
      ),
      QuizQuestion(
        question: 'Hàu, nghêu, sò là nguồn khoáng chất nào nổi bật?',
        questionEn: 'Oysters and clams are a notable source of which mineral?',
        options: ['Đường', 'Kẽm', 'Vitamin C', 'Tinh bột'],
        correctIndex: 1,
        optionsEn: ['Sugar', 'Zinc', 'Vitamin C', 'Starch'],
      ),
      QuizQuestion(
        question: 'Vì sao nên hạn chế ăn quá nhiều cá săn mồi lớn (cá kiếm, '
            'cá ngừ lớn)?',
        questionEn: 'Why limit large predatory fish (swordfish, big tuna)?',
        options: [
          'Vì có thể tích tụ thủy ngân',
          'Vì hoàn toàn không có đạm',
          'Vì chứa nhiều tinh bột',
          'Vì gây mất nước',
        ],
        correctIndex: 0,
        optionsEn: [
          'They can accumulate mercury',
          'They have no protein at all',
          'They contain lots of starch',
          'They cause dehydration',
        ],
      ),
      QuizQuestion(
        question: 'Ngoài omega-3, cá còn là nguồn dồi dào chất nào?',
        questionEn: 'Besides omega-3, fish is a rich source of...?',
        options: [
          'Đường tinh luyện',
          'Tinh bột',
          'Đạm chất lượng cao',
          'Chất xơ',
        ],
        correctIndex: 2,
        optionsEn: [
          'Refined sugar',
          'Starch',
          'High-quality protein',
          'Fiber',
        ],
      ),
    ],
  ),

  // ───────────────────────── Eggs & dairy ──────────────────────────
  FoodQuizTopic(
    id: 'eggs_dairy',
    title: 'Trứng & Sữa',
    titleEn: 'Eggs & Dairy',
    emoji: '🥚',
    color: AppColors.yellow,
    blurb: 'Trứng, sữa, sữa chua — đạm và canxi.',
    blurbEn: 'Eggs, milk, yogurt — protein and calcium.',
    quiz: [
      QuizQuestion(
        question: 'Phần nào của trứng nhiều đạm và ít béo nhất?',
        questionEn: 'Which part of an egg is highest in protein, lowest in '
            'fat?',
        options: ['Lòng đỏ', 'Lòng trắng', 'Vỏ trứng', 'Màng vỏ'],
        correctIndex: 1,
        optionsEn: ['Egg yolk', 'Egg white', 'Eggshell', 'Shell membrane'],
      ),
      QuizQuestion(
        question: 'Sữa và chế phẩm từ sữa là nguồn khoáng chất nào cho xương?',
        questionEn: 'Dairy is a key source of which bone mineral?',
        options: ['Canxi', 'Sắt', 'Kẽm', 'Kali'],
        correctIndex: 0,
        optionsEn: ['Calcium', 'Iron', 'Zinc', 'Potassium'],
      ),
      QuizQuestion(
        question: 'Sữa chua tốt cho tiêu hóa nhờ chứa gì?',
        questionEn: 'Yogurt supports digestion because it contains...?',
        options: [
          'Chất bảo quản',
          'Lợi khuẩn (probiotics)',
          'Phẩm màu',
          'Đường hóa học',
        ],
        correctIndex: 1,
        optionsEn: [
          'Preservatives',
          'Probiotics',
          'Food coloring',
          'Artificial sweeteners',
        ],
      ),
      QuizQuestion(
        question: 'Lòng đỏ trứng cung cấp vitamin tan trong dầu nào?',
        questionEn: 'Egg yolk provides which fat-soluble vitamin?',
        options: ['Vitamin C', 'Vitamin B1', 'Vitamin D', 'Chất xơ'],
        correctIndex: 2,
        optionsEn: ['Vitamin C', 'Vitamin B1', 'Vitamin D', 'Fiber'],
      ),
      QuizQuestion(
        question: 'Người không dung nạp lactose nên chọn gì?',
        questionEn: 'What should lactose-intolerant people choose?',
        options: [
          'Uống thật nhiều sữa tươi',
          'Sữa không lactose hoặc sữa thực vật',
          'Nhịn hoàn toàn chất đạm',
          'Chỉ ăn kem',
        ],
        correctIndex: 1,
        optionsEn: [
          'Drink lots of fresh milk',
          'Lactose-free or plant-based milk',
          'Avoid protein entirely',
          'Only eat ice cream',
        ],
      ),
    ],
  ),

  // ──────────────────────── Grains & starches ───────────────────────
  FoodQuizTopic(
    id: 'grains',
    title: 'Ngũ cốc & Tinh bột',
    titleEn: 'Grains & Starches',
    emoji: '🌾',
    color: AppColors.orange,
    blurb: 'Cơm, bánh mì, yến mạch — năng lượng và chất xơ.',
    blurbEn: 'Rice, bread, oats — energy and fiber.',
    quiz: [
      QuizQuestion(
        question: 'Vì sao ngũ cốc nguyên cám tốt hơn loại tinh chế?',
        questionEn: 'Why are whole grains better than refined ones?',
        options: [
          'Giữ được chất xơ và vi chất',
          'Vì nhiều đường hơn',
          'Vì không còn dinh dưỡng',
          'Vì ít nước hơn',
        ],
        correctIndex: 0,
        optionsEn: [
          'They keep their fiber and micronutrients',
          'Because they have more sugar',
          'Because they have no nutrients left',
          'Because they have less water',
        ],
      ),
      QuizQuestion(
        question: 'Nhóm tinh bột cung cấp chủ yếu điều gì cho cơ thể?',
        questionEn: 'Starchy foods mainly provide the body with...?',
        options: [
          'Omega-3',
          'Năng lượng (carbohydrate)',
          'Toàn bộ vitamin C',
          'Canxi',
        ],
        correctIndex: 1,
        optionsEn: [
          'Omega-3',
          'Energy (carbohydrate)',
          'All the vitamin C',
          'Calcium',
        ],
      ),
      QuizQuestion(
        question: 'Yến mạch nổi tiếng với chất xơ hòa tan nào giúp giảm '
            'cholesterol?',
        questionEn: 'Oats are famous for which cholesterol-lowering soluble '
            'fiber?',
        options: ['Gluten', 'Casein', 'Beta-glucan', 'Fructose'],
        correctIndex: 2,
        optionsEn: ['Gluten', 'Casein', 'Beta-glucan', 'Fructose'],
      ),
      QuizQuestion(
        question: 'Chất xơ trong ngũ cốc nguyên hạt giúp ích gì?',
        questionEn: 'What does fiber in whole grains help with?',
        options: [
          'Hỗ trợ tiêu hóa và tạo cảm giác no lâu',
          'Làm tăng đường huyết tức thì',
          'Thay thế nước uống',
          'Gây táo bón',
        ],
        correctIndex: 0,
        optionsEn: [
          'Supports digestion and keeps you full longer',
          'Spikes blood sugar instantly',
          'Replaces drinking water',
          'Causes constipation',
        ],
      ),
      QuizQuestion(
        question: 'Lựa chọn nào tốt cho đường huyết ổn định hơn?',
        questionEn: 'Which choice gives steadier blood sugar?',
        options: [
          'Nước ngọt có ga',
          'Bánh kẹo tinh luyện',
          'Gạo lứt / ngũ cốc nguyên hạt',
          'Kẹo ngọt',
        ],
        correctIndex: 2,
        optionsEn: [
          'Fizzy soft drinks',
          'Refined cakes and sweets',
          'Brown rice / whole grains',
          'Candy',
        ],
      ),
    ],
  ),

  // ─────────────────────── Plant protein & nuts ─────────────────────
  FoodQuizTopic(
    id: 'plant_protein',
    title: 'Đạm thực vật & Hạt',
    titleEn: 'Plant Protein & Nuts',
    emoji: '🥜',
    color: AppColors.green,
    blurb: 'Đậu, đậu phụ, các loại hạt — đạm cho người ăn chay.',
    blurbEn: 'Beans, tofu, nuts — protein for vegetarians.',
    quiz: [
      QuizQuestion(
        question: 'Đậu (đỗ) và đậu lăng là nguồn dinh dưỡng nào?',
        questionEn: 'Beans and lentils are a source of...?',
        options: [
          'Đạm thực vật và chất xơ',
          'Chỉ có đường',
          'Hoàn toàn không có đạm',
          'Chỉ có omega-3',
        ],
        correctIndex: 0,
        optionsEn: [
          'Plant protein and fiber',
          'Only sugar',
          'No protein at all',
          'Only omega-3',
        ],
      ),
      QuizQuestion(
        question: 'Đậu phụ (tofu) được làm từ gì?',
        questionEn: 'Tofu is made from...?',
        options: ['Lúa mì', 'Đậu nành', 'Sữa bò', 'Ngô'],
        correctIndex: 1,
        optionsEn: ['Wheat', 'Soybeans', 'Cow milk', 'Corn'],
      ),
      QuizQuestion(
        question: 'Các loại hạt (óc chó, hạnh nhân) giàu loại chất béo nào?',
        questionEn: 'Nuts (walnuts, almonds) are rich in which type of fat?',
        options: [
          'Chất béo chuyển hóa (trans fat)',
          'Chất béo không bão hòa (tốt)',
          'Đường',
          'Cholesterol',
        ],
        correctIndex: 1,
        optionsEn: [
          'Trans fat',
          'Unsaturated (good) fat',
          'Sugar',
          'Cholesterol',
        ],
      ),
      QuizQuestion(
        question: 'Để có đủ đạm, người ăn chay nên kết hợp?',
        questionEn: 'For complete protein, vegetarians should combine...?',
        options: [
          'Đậu/đỗ với ngũ cốc',
          'Chỉ ăn trái cây',
          'Chỉ uống nước ép',
          'Chỉ ăn rau xà lách',
        ],
        correctIndex: 0,
        optionsEn: [
          'Beans with grains',
          'Only fruit',
          'Only juice',
          'Only lettuce',
        ],
      ),
      QuizQuestion(
        question: 'Một ưu điểm của đạm thực vật so với đạm động vật?',
        questionEn: 'One advantage of plant protein over animal protein?',
        options: [
          'Thường kèm chất xơ và ít béo bão hòa',
          'Chứa nhiều cholesterol hơn',
          'Không có giá trị dinh dưỡng',
          'Luôn kém an toàn',
        ],
        correctIndex: 0,
        optionsEn: [
          'Often comes with fiber and less saturated fat',
          'Contains more cholesterol',
          'Has no nutritional value',
          'Is always less safe',
        ],
      ),
    ],
  ),
];

/// Look up a food-quiz topic by id.
FoodQuizTopic foodQuizById(String id) =>
    kFoodQuizzes.firstWhere((t) => t.id == id, orElse: () => kFoodQuizzes.first);
