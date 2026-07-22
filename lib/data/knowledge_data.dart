import 'package:flutter/material.dart' show Color;

import '../models/knowledge_models.dart';
import '../theme/app_colors.dart';

/// The Nutrition Rainbow knowledge base.
///
/// Content is transcribed and condensed from the project proposal. English is
/// the primary language; each item also carries a short Vietnamese summary so
/// every page reads bilingually. Source URLs are reproduced verbatim so the
/// in-app citations link to the exact studies referenced in the proposal.
const List<RainbowBand> kBands = [
  // ══════════════════════════════ RED ══════════════════════════════
  RainbowBand(
    id: 'red',
    nameEn: 'Red',
    nameVi: 'Đỏ',
    color: AppColors.red,
    colorLight: AppColors.redLight,
    onColor: AppColors.white,
    introEn:
        'Red and purple foods are rich in antioxidant pigments that protect '
        'the heart, calm inflammation and support the brain.',
    introVi:
        'Thực phẩm màu đỏ và tím giàu sắc tố chống oxy hóa, tốt cho tim mạch, '
        'giảm viêm và hỗ trợ não bộ.',
    compounds: [
      Compound(
        id: 'anthocyanins_red',
        name: 'Anthocyanins',
        nameVi: 'Anthocyanin',
        emoji: '🍓',
        taglineEn: 'Antioxidant pigments in red, purple & blue produce',
        taglineVi: 'Sắc tố chống oxy hóa trong quả đỏ, tím và xanh',
        definitionEn:
            'Anthocyanins are a group of antioxidants found in red, purple and '
            'blue fruits and vegetables, belonging to the flavonoid family.',
        definitionVi:
            'Anthocyanin là nhóm chất chống oxy hóa thuộc họ flavonoid, có '
            'trong trái cây và rau củ màu đỏ, tím và xanh dương.',
        benefits: [
          Benefit(
            titleEn: 'Reducing inflammation',
            titleVi: 'Giảm viêm',
            bodyEn:
                'Anthocyanins reduce external stimulation and inhibit the '
                'NF-κB signalling pathway that switches on pro-inflammatory '
                'genes, and can also block COX-2/AP-1 and MAPK pathways.',
            bodyVi:
                'Ức chế con đường NF-κB và các gen gây viêm (COX-2, AP-1, MAPK).',
            source: Source(
                'PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC8540239/'),
          ),
          Benefit(
            titleEn: 'Protecting against type-2 diabetes',
            titleVi: 'Phòng tiểu đường type 2',
            bodyEn:
                'Berry consumption was linked to an 18% lower risk of type 2 '
                'diabetes. Like the drug acarbose, anthocyanins slow '
                'carbohydrate digestion, lowering glucose released into the '
                'blood.',
            bodyVi:
                'Ăn quả mọng giảm ~18% nguy cơ tiểu đường type 2; làm chậm '
                'tiêu hóa tinh bột, giảm đường huyết.',
            source: Source(
                'PubMed', 'https://pubmed.ncbi.nlm.nih.gov/27530472/'),
          ),
          Benefit(
            titleEn: 'Cancer-fighting abilities',
            titleVi: 'Hỗ trợ chống ung thư',
            bodyEn:
                'As free-radical scavengers they act on the antioxidant '
                'system, reducing oxidative-stress damage and the gene '
                'mutations that can turn normal cells cancerous.',
            bodyVi:
                'Dọn gốc tự do, giảm stress oxy hóa và đột biến gen dẫn tới '
                'khối u.',
            source: Source(
                'PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC5429338/'),
          ),
          Benefit(
            titleEn: 'Improving brain health',
            titleVi: 'Cải thiện sức khỏe não',
            bodyEn:
                'Even taken orally they reach useful concentrations and help '
                'protect neurons from premature death, supporting the brain '
                'and guarding against neurodegenerative disease.',
            bodyVi:
                'Bảo vệ tế bào thần kinh, hỗ trợ trí não và phòng bệnh thoái '
                'hóa thần kinh.',
            source: Source(
                'PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC7022568/'),
          ),
        ],
        sourcesEn:
            'Red and purple berries, grapes, apples, plums and cabbage, plus '
            'other deeply colored produce.',
        sourcesVi:
            'Quả mọng đỏ/tím, nho, táo, mận, bắp cải tím và các loại rau quả '
            'màu đậm.',
        sourceFoods: [
          FoodEmoji('🍓', 'Strawberry'),
          FoodEmoji('🍇', 'Grapes'),
          FoodEmoji('🍎', 'Apple'),
          FoodEmoji('🫐', 'Berries'),
          FoodEmoji('🍆', 'Cabbage'),
        ],
      ),
      Compound(
        id: 'naringenin',
        name: 'Naringenin',
        nameVi: 'Naringenin',
        emoji: '🍅',
        taglineEn: 'A citrus flavonoid with antioxidant & anti-inflammatory action',
        taglineVi: 'Flavonoid từ quả có múi, chống oxy hóa & kháng viêm',
        definitionEn:
            'Naringenin is a flavonoid of the flavanone class found mainly in '
            'citrus fruits. Its structure drives antioxidant activity, and it '
            'also has analgesic, anti-inflammatory, nephroprotective '
            '(kidney-protecting), neuroprotective and antimicrobial effects.',
        definitionVi:
            'Naringenin là flavonoid nhóm flavanone, chủ yếu trong quả có múi; '
            'chống oxy hóa, giảm đau, kháng viêm, bảo vệ thận và thần kinh.',
        definitionSource: Source('ScienceDirect',
            'https://www.sciencedirect.com/topics/neuroscience/naringenin'),
        benefits: [
          Benefit(
            titleEn: 'Anti-inflammatory effects',
            titleVi: 'Kháng viêm',
            bodyEn:
                'It eases inflammation in autoimmune conditions (RA, IBD, MS, '
                'SLE, diabetes) by lowering inflammatory mediators via '
                'pathways such as Tregs and NF-κB.',
            bodyVi:
                'Giảm chất trung gian gây viêm qua con đường Tregs/NF-κB, hỗ '
                'trợ bệnh tự miễn.',
            source: Source('ScienceDirect',
                'https://www.sciencedirect.com/science/article/pii/S0753332223007801?via%3Dihub'),
          ),
          Benefit(
            titleEn: 'Supporting the brain',
            titleVi: 'Hỗ trợ não bộ',
            bodyEn:
                'In neurons it stimulates autophagy-promoting proteins that '
                'clear toxic waste and damaged parts, which may help prevent '
                'or ease Alzheimer\'s and Parkinson\'s disease.',
            bodyVi:
                'Kích thích tự thực bào dọn "rác" tế bào thần kinh, hỗ trợ '
                'phòng Alzheimer/Parkinson.',
            source: Source('ScienceDirect',
                'https://www.sciencedirect.com/science/article/pii/S0361923023002605'),
          ),
        ],
        sourcesEn:
            'Citrus fruits such as oranges, pomelos and grapefruits, plus '
            'tomatoes, fenugreek and coffee.',
        sourcesVi: 'Cam, bưởi, chanh và cả cà chua, cỏ cà ri, cà phê.',
        sourcesSource: Source(
            'PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC9686724/'),
        sourceFoods: [
          FoodEmoji('🍊', 'Orange'),
          FoodEmoji('🍋', 'Citrus'),
          FoodEmoji('🍅', 'Tomato'),
          FoodEmoji('☕', 'Coffee'),
        ],
      ),
    ],
  ),

  // ════════════════════════════ ORANGE ═════════════════════════════
  RainbowBand(
    id: 'orange',
    nameEn: 'Orange',
    nameVi: 'Cam',
    color: AppColors.orange,
    colorLight: AppColors.orangeLight,
    onColor: AppColors.white,
    introEn:
        'Orange and yellow foods deliver vitamin C and beta-carotene for '
        'immunity, vision and healthy skin.',
    introVi:
        'Thực phẩm cam và vàng giàu vitamin C và beta-caroten, tốt cho miễn '
        'dịch, thị lực và làn da.',
    compounds: [
      Compound(
        id: 'vitamin_c',
        name: 'Vitamin C',
        nameVi: 'Vitamin C',
        emoji: '🍊',
        taglineEn: 'An essential water-soluble antioxidant vitamin',
        taglineVi: 'Vitamin tan trong nước thiết yếu, chống oxy hóa',
        definitionEn:
            'Vitamin C (L-ascorbic acid) is a water-soluble vitamin naturally '
            'present in some foods, added to others, or taken as a supplement. '
            'The body cannot synthesize it, so it is essential to include it '
            'in the diet.',
        definitionVi:
            'Vitamin C (axit L-ascorbic) tan trong nước, có trong nhiều thực '
            'phẩm; cơ thể không tự tổng hợp được nên phải bổ sung qua ăn uống.',
        definitionSource: Source(
            'PubMed', 'https://pubmed.ncbi.nlm.nih.gov/17884994/'),
        benefits: [
          Benefit(
            titleEn: 'Reduced risk of heart disease',
            titleVi: 'Giảm nguy cơ bệnh tim',
            bodyEn:
                'Higher supplemental vitamin C intake is linked to lower '
                'coronary heart disease (CHD). People taking more than 700 mg '
                'had a relatively lower risk of CHD than those who took none.',
            bodyVi:
                'Bổ sung vitamin C liều cao (>700 mg) gắn với nguy cơ bệnh '
                'mạch vành thấp hơn.',
            source: Source(
                'PubMed', 'https://pubmed.ncbi.nlm.nih.gov/15585762/'),
          ),
          Benefit(
            titleEn: 'Preventing gout',
            titleVi: 'Phòng bệnh gút',
            bodyEn:
                'Vitamin C competes with uric acid for reabsorption so more '
                'leaves the body in urine; randomized research shows gout risk '
                'falls as vitamin C intake rises.',
            bodyVi: 'Giúp thải axit uric ra ngoài, giảm nguy cơ gút.',
            source: Source(
                'PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC2767211/'),
          ),
          Benefit(
            titleEn: 'Enhancing iron absorption',
            titleVi: 'Tăng hấp thu sắt',
            bodyEn:
                'Ascorbic acid strongly boosts iron absorption and can '
                'overcome dietary inhibitors, helping prevent anemia — '
                'especially with plant (non-heme) iron from a veggie-heavy '
                'meal.',
            bodyVi:
                'Tăng hấp thu sắt (nhất là sắt thực vật), giúp phòng thiếu máu.',
            source: Source(
                'NCBI Bookshelf', 'https://www.ncbi.nlm.nih.gov/books/NBK448204/'),
          ),
        ],
        sourcesEn:
            'Citrus fruits like oranges and lemons are best known sources of '
            'Vitamin C, but it is also in kale, kiwis and peppers.',
        sourcesVi: 'Cam, chanh là quen thuộc nhất; ngoài ra có cải xoăn, kiwi, ớt chuông.',
        sourceFoods: [
          FoodEmoji('🍊', 'Orange'),
          FoodEmoji('🍋', 'Lemon'),
          FoodEmoji('🥝', 'Kiwi'),
          FoodEmoji('🫑', 'Pepper'),
          FoodEmoji('🥬', 'Kale'),
        ],
      ),
      Compound(
        id: 'beta_carotene',
        name: 'Beta-carotene',
        nameVi: 'Beta-caroten',
        emoji: '🥕',
        taglineEn: 'A provitamin-A carotenoid pigment',
        taglineVi: 'Sắc tố carotenoid, tiền chất của vitamin A',
        definitionEn:
            'Beta-carotene is a natural plant pigment in many orange, yellow '
            'and red fruits and vegetables. It belongs to the carotenoid '
            'family and is a provitamin A compound — the body converts it into '
            'vitamin A as needed. It is also a powerful antioxidant that '
            'protects cells from free radicals.',
        definitionVi:
            'Beta-caroten là sắc tố thực vật thuộc họ carotenoid, là tiền chất '
            'vitamin A (cơ thể chuyển hóa khi cần) và là chất chống oxy hóa mạnh.',
        benefits: [
          Benefit(
            titleEn: 'Improves cognitive function',
            titleVi: 'Cải thiện nhận thức',
            bodyEn:
                'Its antioxidant properties may support brain health; some '
                'studies suggest long-term intake aids memory, and diets rich '
                'in it may lower the risk of memory decline and dementia.',
            bodyVi: 'Hỗ trợ trí nhớ và giảm nguy cơ suy giảm nhận thức.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/17998490/'),
          ),
          Benefit(
            titleEn: 'Improves eyesight',
            titleVi: 'Cải thiện thị lực',
            bodyEn:
                'Converted to vitamin A it maintains normal vision and may '
                'reduce the risk of age-related macular degeneration (AMD), a '
                'leading cause of vision loss.',
            bodyVi:
                'Chuyển hóa thành vitamin A, duy trì thị lực, giảm nguy cơ '
                'thoái hóa điểm vàng.',
            source: Source('PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC1462955/'),
          ),
          Benefit(
            titleEn: 'Supports lung health',
            titleVi: 'Bảo vệ phổi',
            bodyEn:
                'As vitamin A it supports lung function; whole-food sources '
                'may lower lung-cancer risk, though supplements do not and may '
                'even raise risk in smokers.',
            bodyVi:
                'Hỗ trợ chức năng phổi (từ thực phẩm, không phải viên bổ sung '
                '— vốn có thể hại người hút thuốc).',
            source: Source('NEJM', 'https://www.nejm.org/doi/full/10.1056/NEJM199404143301501'),
          ),
          Benefit(
            titleEn: 'Protects skin',
            titleVi: 'Bảo vệ da',
            bodyEn:
                'Its antioxidant action helps defend skin against UV and keeps '
                'it healthy, but the effect is mild and cannot replace '
                'sunscreen.',
            bodyVi:
                'Hỗ trợ bảo vệ da khỏi tia UV (nhẹ, không thay được kem chống nắng).',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/23053552/'),
          ),
          Benefit(
            titleEn: 'May help prevent some cancers',
            titleVi: 'Có thể phòng một số ung thư',
            bodyEn:
                'From whole foods (not supplements) it is associated with '
                'lower risk of premenopausal breast, lung and pancreatic '
                'cancers.',
            bodyVi:
                'Từ thực phẩm tự nhiên, liên quan giảm nguy cơ ung thư vú, '
                'phổi và tụy.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/23221879/'),
          ),
        ],
        sourcesEn:
            'Carrots, pumpkin and sweet potato are richest in Beta-carotene, '
            'plus mangoes, apricots, papaya, red/yellow peppers and dark '
            'leafy greens like spinach and kale.',
        sourcesVi:
            'Cà rốt, bí đỏ, khoai lang; xoài, mơ, đu đủ, ớt chuông và rau lá '
            'xanh đậm.',
        sourceFoods: [
          FoodEmoji('🥕', 'Carrot'),
          FoodEmoji('🎃', 'Pumpkin'),
          FoodEmoji('🍠', 'Sweet potato'),
          FoodEmoji('🥭', 'Mango'),
          FoodEmoji('🌶️', 'Pepper'),
        ],
      ),
    ],
  ),

  // ════════════════════════════ YELLOW ═════════════════════════════
  RainbowBand(
    id: 'yellow',
    nameEn: 'Yellow',
    nameVi: 'Vàng',
    color: AppColors.yellow,
    colorLight: AppColors.yellowDeep,
    onColor: AppColors.yellowInk,
    introEn:
        'Yellow foods are rich in flavonoids and curcumin — antioxidants that '
        'calm inflammation and protect the heart and brain.',
    introVi:
        'Thực phẩm màu vàng giàu flavonoid và curcumin — chống oxy hóa, kháng '
        'viêm, bảo vệ tim và não.',
    compounds: [
      Compound(
        id: 'flavonoids',
        name: 'Flavonoids',
        nameVi: 'Flavonoid',
        emoji: '🧅',
        taglineEn: 'A large family of plant polyphenol antioxidants',
        taglineVi: 'Nhóm polyphenol thực vật chống oxy hóa',
        definitionEn:
            'Flavonoids (bioflavonoids) are a large group of plant polyphenols '
            '— more than 6,000 identified, in six main subclasses. In plants '
            'they create color and flavour and defend against microbes and '
            'pests; in the body they act as powerful antioxidants that '
            'neutralise free radicals.',
        definitionVi:
            'Flavonoid (bioflavonoid) là nhóm polyphenol thực vật lớn (hơn '
            '6.000 loại, 6 phân nhóm); trong cơ thể là chất chống oxy hóa '
            'mạnh, trung hòa gốc tự do.',
        benefits: [
          Benefit(
            titleEn: 'Antioxidant protection',
            titleVi: 'Chống oxy hóa',
            bodyEn:
                'They neutralise harmful free radicals and reduce oxidative '
                'stress, lowering the risk of several chronic diseases.',
            bodyVi: 'Trung hòa gốc tự do, giảm stress oxy hóa.',
            source: Source('PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC5084045/'),
          ),
          Benefit(
            titleEn: 'Anti-inflammatory effects',
            titleVi: 'Kháng viêm',
            bodyEn:
                'They limit inflammatory reactions — important because chronic '
                'inflammation is linked to many diseases.',
            bodyVi: 'Hạn chế phản ứng viêm mạn tính.',
            source: Source('DOI', 'https://doi.org/10.3390/molecules27092901'),
          ),
          Benefit(
            titleEn: 'Heart & blood-vessel health',
            titleVi: 'Tốt cho tim mạch',
            bodyEn:
                'They support healthy vessels and circulation; regular intake '
                'may lower heart-disease and stroke risk (flavones, flavanones '
                'and anthocyanins especially).',
            bodyVi:
                'Hỗ trợ mạch máu và tuần hoàn, giảm nguy cơ bệnh tim và đột quỵ.',
            source: Source('Wiley', 'https://onlinelibrary.wiley.com/doi/10.1002/mnfr.202001019'),
          ),
          Benefit(
            titleEn: 'Lower type-2 diabetes risk',
            titleVi: 'Giảm nguy cơ tiểu đường type 2',
            bodyEn:
                'Research suggests about 300 mg of flavonoids a day may lower '
                'the risk of type 2 diabetes by roughly 5%.',
            bodyVi: 'Khoảng 300 mg/ngày có thể giảm ~5% nguy cơ.',
            source: Source('PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC5959406/'),
          ),
          Benefit(
            titleEn: 'Brain & cognitive support',
            titleVi: 'Hỗ trợ trí não',
            bodyEn:
                'They protect brain cells and influence signalling pathways '
                'involved in memory, learning and cognitive performance.',
            bodyVi: 'Bảo vệ tế bào não, hỗ trợ trí nhớ và học tập.',
            source: Source('Neurology', 'https://www.neurology.org/doi/10.1212/WNL.0000000000201541'),
          ),
          Benefit(
            titleEn: 'Cancer prevention & immunity',
            titleVi: 'Phòng ung thư & miễn dịch',
            bodyEn:
                'By balancing antioxidants and free radicals and supporting '
                'the immune system, they help the body prevent and fight '
                'cancer.',
            bodyVi: 'Cân bằng chống oxy hóa và tăng cường miễn dịch.',
            source: Source('ScienceDirect', 'https://www.sciencedirect.com/science/article/pii/S2590257123000159?via=ihub'),
          ),
        ],
        sourcesEn:
            'Broccoli, kale, tomatoes and onions; pears, peaches and '
            'strawberries; nuts, cocoa, green tea and dark chocolate; and '
            'anthocyanin-rich grapes, blueberries, raspberries and red wine.',
        sourcesVi:
            'Bông cải, cải xoăn, cà chua, hành; lê, đào, dâu; hạt, ca cao, '
            'trà xanh, socola đen; nho, việt quất, mâm xôi.',
        sourceFoods: [
          FoodEmoji('🥦', 'Broccoli'),
          FoodEmoji('🧅', 'Onion'),
          FoodEmoji('🍵', 'Green tea'),
          FoodEmoji('🍫', 'Dark cocoa'),
          FoodEmoji('🍓', 'Berries'),
        ],
      ),
      Compound(
        id: 'curcumin',
        name: 'Curcumin',
        nameVi: 'Curcumin',
        emoji: '🍛',
        taglineEn: 'The bright-yellow anti-inflammatory compound in turmeric',
        taglineVi: 'Hợp chất vàng trong nghệ, kháng viêm mạnh',
        showCurcuminDiagram: true,
        definitionEn:
            'Curcumin is a bioactive polyphenol (a curcuminoid) from turmeric '
            '(Curcuma longa). It gives turmeric its bright yellow color and '
            'has strong anti-inflammatory and antioxidant effects; studies '
            'suggest it can ease arthritis pain and may inhibit some tumours '
            '(e.g. colorectal). Because its effects are not fully established '
            'and there is no standard dose, people who are pregnant or on '
            'certain medications should consult a professional first.',
        definitionVi:
            'Curcumin là polyphenol (curcuminoid) trong củ nghệ, tạo màu '
            'vàng; kháng viêm và chống oxy hóa mạnh, có thể giảm đau viêm '
            'khớp và hỗ trợ chống một số khối u. Chưa có liều chuẩn — người '
            'mang thai hoặc đang dùng thuốc nên hỏi ý kiến bác sĩ.',
        benefits: [
          Benefit(
            titleEn: 'Strong anti-inflammatory effects',
            titleVi: 'Kháng viêm mạnh',
            bodyEn:
                'It reduces inflammation and pain and can improve symptoms in '
                'inflammatory diseases such as arthritis.',
            bodyVi: 'Giảm viêm và đau, hỗ trợ bệnh viêm khớp.',
            source: Source('PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC5003001/'),
          ),
          Benefit(
            titleEn: 'Antioxidant activity',
            titleVi: 'Chống oxy hóa',
            bodyEn:
                'It reduces oxidative stress by neutralising harmful molecules '
                'that damage cells.',
            bodyVi: 'Trung hòa phân tử gây hại, giảm stress oxy hóa.',
            source: Source('PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC5664031/'),
          ),
          Benefit(
            titleEn: 'Cancer support',
            titleVi: 'Hỗ trợ chống ung thư',
            bodyEn:
                'Some research suggests it may slow or inhibit tumour growth '
                'and support the body\'s natural defences.',
            bodyVi: 'Có thể làm chậm khối u và hỗ trợ đề kháng tự nhiên.',
            source: Source('PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC2758121/'),
          ),
          Benefit(
            titleEn: 'Skin health',
            titleVi: 'Tốt cho da',
            bodyEn:
                'It may help eczema, acne and psoriasis by easing oxidative '
                'stress, boosting collagen and aiding tissue repair.',
            bodyVi:
                'Hỗ trợ chàm, mụn, vảy nến nhờ giảm oxy hóa và tăng collagen.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/27213821/'),
          ),
          Benefit(
            titleEn: 'Weight & metabolic support',
            titleVi: 'Hỗ trợ chuyển hóa',
            bodyEn:
                'It may regulate lipid metabolism and improve insulin '
                'sensitivity, supporting weight and metabolic health.',
            bodyVi: 'Điều hòa mỡ máu và tăng nhạy insulin.',
            source: Source('PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC6582779/'),
          ),
          Benefit(
            titleEn: 'Allergy & asthma relief',
            titleVi: 'Giảm dị ứng & hen',
            bodyEn:
                'Its anti-inflammatory action may reduce coughing, itching '
                'and sneezing and lower the risk of asthma attacks.',
            bodyVi: 'Giảm ho, ngứa, hắt hơi và nguy cơ lên cơn hen.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/27789120/'),
          ),
          Benefit(
            titleEn: 'Regulating cholesterol',
            titleVi: 'Điều hòa cholesterol',
            bodyEn:
                'Clinical studies suggest turmeric may lower cholesterol and '
                'triglycerides, useful in diabetes and metabolic disorders.',
            bodyVi: 'Có thể giảm cholesterol và triglyceride.',
            source: Source('PMC · NCBI', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC5637251/'),
          ),
        ],
        sourcesEn:
            'Turmeric root (Curcuma longa) and turmeric powder, dishes cooked '
            'with turmeric (common in Asian cuisine), and curcumin '
            'supplements or extracts.',
        sourcesVi:
            'Củ nghệ và bột nghệ, các món ăn dùng nghệ, và viên hoặc chiết '
            'xuất curcumin.',
        sourceFoods: [
          FoodEmoji('🍠', 'Turmeric'),
          FoodEmoji('🍛', 'Curry'),
        ],
      ),
    ],
  ),

  // ════════════════════════════ GREEN ══════════════════════════════
  RainbowBand(
    id: 'green',
    nameEn: 'Green',
    nameVi: 'Xanh lá',
    color: AppColors.green,
    colorLight: AppColors.greenLight,
    onColor: AppColors.white,
    introEn:
        'Green vegetables supply chlorophyll, lutein, sulforaphane and more — '
        'for detox, eye health and cell protection.',
    introVi:
        'Rau xanh cung cấp chlorophyll, lutein, sulforaphane… giúp thải độc, '
        'sáng mắt và bảo vệ tế bào.',
    compounds: [
      Compound(
        id: 'chlorophyll',
        name: 'Chlorophyll',
        nameVi: 'Chlorophyll (diệp lục)',
        emoji: '🫛',
        taglineEn: 'The green pigment of photosynthesis',
        taglineVi: 'Sắc tố xanh của quá trình quang hợp',
        definitionEn:
            'Chlorophyll is the green pigment in plants, algae and '
            'cyanobacteria, held in chloroplasts, that captures light for '
            'photosynthesis to make glucose and oxygen. In nutrition it is '
            'consumed through green vegetables or supplements and is studied '
            'for detoxification, digestion and overall health.',
        definitionVi:
            'Chlorophyll (diệp lục) là sắc tố xanh trong lục lạp, thu ánh sáng '
            'để quang hợp; được nghiên cứu hỗ trợ thải độc, tiêu hóa và sức '
            'khỏe chung.',
        benefits: [
          Benefit(
            titleEn: 'Detoxifying the body',
            titleVi: 'Thải độc',
            bodyEn:
                'It may improve circulation and oxygen delivery, stimulate '
                'hemoglobin, bind certain heavy metals and support bowel '
                'cleansing.',
            bodyVi:
                'Cải thiện tuần hoàn, kích thích hemoglobin, gắn kim loại '
                'nặng và hỗ trợ làm sạch ruột.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/11724948/'),
          ),
          Benefit(
            titleEn: 'Red blood cells & heart',
            titleVi: 'Tạo máu & tim mạch',
            bodyEn:
                'It may promote red-blood-cell production (easing anemia '
                'symptoms) and, being antioxidant, may help lower cholesterol '
                'and support the heart.',
            bodyVi:
                'Hỗ trợ tạo hồng cầu (giảm thiếu máu) và có thể giảm cholesterol.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/32526968/'),
          ),
          Benefit(
            titleEn: 'Protecting cells',
            titleVi: 'Bảo vệ tế bào',
            bodyEn:
                'Its antioxidant, anti-inflammatory action reduces oxidative '
                'stress and may help limit tumour development.',
            bodyVi: 'Giảm oxy hóa, hạn chế tổn thương và khối u.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/11018464/'),
          ),
          Benefit(
            titleEn: 'Liver & digestion',
            titleVi: 'Gan & tiêu hóa',
            bodyEn:
                'It may support liver detox and digestion, strengthen '
                'immunity, ease asthma symptoms and help skin repair.',
            bodyVi: 'Hỗ trợ gan, tiêu hóa, miễn dịch và phục hồi da.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/15774490/'),
          ),
        ],
        sourcesEn:
            'Green leafy vegetables — spinach, kale, lettuce, broccoli, '
            'parsley, green beans and peas — plus seaweed and algae; the '
            'darker the green is, the more chlorophyll it contains.',
        sourcesVi:
            'Rau lá xanh (cải bó xôi, cải xoăn, xà lách, bông cải, mùi tây, '
            'đậu) và tảo; càng xanh đậm càng nhiều diệp lục.',
        sourceFoods: [
          FoodEmoji('🥬', 'Spinach'),
          FoodEmoji('🥦', 'Broccoli'),
          FoodEmoji('🌱', 'Peas'),
          FoodEmoji('🌿', 'Parsley'),
        ],
      ),
      Compound(
        id: 'lutein',
        name: 'Lutein',
        nameVi: 'Lutein',
        emoji: '🥗',
        taglineEn: 'A carotenoid that protects the eyes and skin',
        taglineVi: 'Carotenoid bảo vệ mắt và da',
        definitionEn:
            'Lutein is a carotenoid antioxidant made only by plants, so humans '
            'must get it from diet. It concentrates in the eye\'s macula and '
            'in the brain, protects cells from free radicals, and helps shield '
            'skin from sunlight and blue light. Light cooking can improve '
            'absorption, but very high heat reduces carotenoid content.',
        definitionVi:
            'Lutein là carotenoid chống oxy hóa, chỉ có ở thực vật nên phải '
            'nạp qua ăn uống; tập trung ở điểm vàng của mắt và não. Nấu nhẹ '
            'giúp hấp thu tốt hơn, nhiệt quá cao làm giảm hàm lượng.',
        benefits: [
          Benefit(
            titleEn: 'Enhancing eye health',
            titleVi: 'Tốt cho mắt',
            bodyEn:
                'Concentrated in the macula (the retina\'s centre of vision), '
                'its antioxidant action may reduce the risk of age-related '
                'macular degeneration (AMD).',
            bodyVi: 'Tập trung ở điểm vàng, giảm nguy cơ thoái hóa điểm vàng.',
            source: Source('Ophthalmology', 'https://www.aaojournal.org/article/S0161-6420(24)00425-1/fulltext'),
          ),
          Benefit(
            titleEn: 'Protecting collagen',
            titleVi: 'Bảo vệ collagen',
            bodyEn:
                'It helps maintain skin collagen for elasticity and firmness '
                'and may slow visible signs of aging.',
            bodyVi: 'Giữ collagen, tăng độ đàn hồi, làm chậm lão hóa da.',
            source: Source('DOI', 'https://doi.org/10.1007/s00403-007-0779-0'),
          ),
          Benefit(
            titleEn: 'Even, hydrated skin',
            titleVi: 'Da đều màu & đủ ẩm',
            bodyEn:
                'It helps guard against UV damage, may reduce excess melanin '
                '(uneven tone) and supports skin hydration.',
            bodyVi: 'Chống UV, giảm melanin dư và giữ ẩm da.',
            source: Source('DOI', 'https://doi.org/10.3746/pnf.2021.26.4.425'),
          ),
          Benefit(
            titleEn: 'Cell protection',
            titleVi: 'Bảo vệ tế bào',
            bodyEn:
                'It protects fats, proteins and DNA from oxidation and helps '
                'recycle antioxidants such as glutathione.',
            bodyVi:
                'Bảo vệ lipid, protein, DNA và tái tạo chất chống oxy hóa '
                '(glutathione).',
            source: Source('DOI', 'https://doi.org/10.18388/abp.2012_2185'),
          ),
        ],
        sourcesEn:
            'Dark leafy greens — spinach, kale, broccoli, peas, zucchini and '
            'corn — and fruits such as kiwi, grapes and oranges.',
        sourcesVi:
            'Rau lá xanh đậm (cải bó xôi, cải xoăn, bông cải, đậu Hà Lan, bí '
            'ngòi, ngô) và kiwi, nho, cam.',
        sourceFoods: [
          FoodEmoji('🥬', 'Kale'),
          FoodEmoji('🥦', 'Broccoli'),
          FoodEmoji('🌽', 'Corn'),
          FoodEmoji('🥝', 'Kiwi'),
          FoodEmoji('🍇', 'Grapes'),
        ],
      ),
      Compound(
        id: 'sulforaphane',
        name: 'Sulforaphane',
        nameVi: 'Sulforaphane',
        emoji: '🥦',
        taglineEn: 'A protective compound from raw cruciferous veg',
        taglineVi: 'Hợp chất bảo vệ từ rau họ cải tươi',
        definitionEn:
            'Sulforaphane is a sulfur-containing isothiocyanate from '
            'cruciferous vegetables. It forms when glucoraphanin meets the '
            'enzyme myrosinase — released when veg is cut, chopped or chewed — '
            'so preparation matters. Raw broccoli can hold up to ten times '
            'more than cooked. It is noted for antioxidant, anti-inflammatory '
            'and detox-supporting properties.',
        definitionVi:
            'Sulforaphane là isothiocyanate chứa lưu huỳnh trong rau họ cải; '
            'hình thành khi cắt/nhai (enzyme myrosinase). Bông cải sống có thể '
            'chứa gấp ~10 lần khi nấu chín.',
        benefits: [
          Benefit(
            titleEn: 'Cancer prevention',
            titleVi: 'Phòng ung thư',
            bodyEn:
                'It activates antioxidant and detox enzymes that guard cells '
                'from carcinogens and may slow some cancer cells (mostly in '
                'concentrated-dose studies).',
            bodyVi:
                'Kích hoạt enzyme thải độc bảo vệ tế bào khỏi chất gây ung thư.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/?term=Broccoli+sprouts:+an+exceptionally+rich+source+of+inducers+of+enzymes+that+protect+against+chemical+carcinogens'),
          ),
          Benefit(
            titleEn: 'Cardiovascular health',
            titleVi: 'Tim mạch',
            bodyEn:
                'Its anti-inflammatory action may protect blood vessels and '
                'help lower high blood pressure.',
            bodyVi: 'Kháng viêm, bảo vệ mạch máu, hạ huyết áp.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/26583056/'),
          ),
          Benefit(
            titleEn: 'Diabetes management',
            titleVi: 'Hỗ trợ tiểu đường',
            bodyEn:
                'It may help lower blood sugar in type 2 diabetes, especially '
                'for people who are obese or poorly controlled.',
            bodyVi: 'Có thể giảm đường huyết ở tiểu đường type 2.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/?term=Sulforaphane+reduces+hepatic+glucose+production+and+improves+glucose+control+in+patients+with+type+2+diabetes'),
          ),
          Benefit(
            titleEn: 'Skin & brain protection',
            titleVi: 'Bảo vệ da & não',
            bodyEn:
                'It may protect skin from UV damage and shield brain cells '
                'through antioxidant and anti-inflammatory action.',
            bodyVi: 'Bảo vệ da khỏi UV và hỗ trợ tế bào não.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/23983898/'),
          ),
          Benefit(
            titleEn: 'Better digestion',
            titleVi: 'Tiêu hóa tốt hơn',
            bodyEn:
                'It may ease constipation and support healthier digestion. '
                '(Most evidence is still from cell or animal studies.)',
            bodyVi: 'Có thể giảm táo bón (bằng chứng chủ yếu từ nghiên cứu tiền lâm sàng).',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/?term=Daily+intake+of+broccoli+sprouts+normalizes+bowel+habits+in+human+healthy+subjects'),
          ),
        ],
        sourcesEn:
            'Cruciferous vegetables, especially raw or lightly cooked — '
            'broccoli and broccoli sprouts (richest), Brussels sprouts, '
            'cabbage, cauliflower, kale and arugula.',
        sourcesVi:
            'Rau họ cải (nhất là mầm và bông cải sống), cải Brussels, bắp cải, '
            'súp lơ, cải xoăn, rocket.',
        sourceFoods: [
          FoodEmoji('🥦', 'Broccoli'),
          FoodEmoji('🥬', 'Cabbage'),
          FoodEmoji('🌱', 'Sprouts'),
        ],
      ),
      Compound(
        id: 'isoflavones',
        name: 'Isoflavones',
        nameVi: 'Isoflavone',
        emoji: '🥜',
        taglineEn: 'Soy phytoestrogens with estrogen-like activity',
        taglineVi: 'Phytoestrogen từ đậu nành, giống estrogen',
        definitionEn:
            'Isoflavones are plant phytoestrogens in the flavonoid family, '
            'found mainly in soybeans and legumes. Their structure resembles '
            'estrogen, so they can bind estrogen receptors and act as agonists '
            'or antagonists. The key soy isoflavones are genistein and '
            'daidzein. Some groups — e.g. people with breast cancer, thyroid '
            'or kidney conditions — should be cautious.',
        definitionVi:
            'Isoflavone là phytoestrogen (họ flavonoid), chủ yếu trong đậu '
            'nành; cấu trúc giống estrogen nên gắn thụ thể estrogen. Hai loại '
            'chính: genistein và daidzein. Một số nhóm bệnh nên thận trọng.',
        benefits: [
          Benefit(
            titleEn: 'Heart health in menopause',
            titleVi: 'Tim mạch tuổi mãn kinh',
            bodyEn:
                'They may protect women from coronary heart disease as '
                'estrogen falls; about 80 mg a day may act like estrogen and '
                'is seen as safer than estrogen therapy.',
            bodyVi:
                'Bảo vệ tim mạch khi estrogen giảm; ~80 mg/ngày, an toàn hơn '
                'liệu pháp estrogen.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/20728290/'),
          ),
          Benefit(
            titleEn: 'Memory & brain',
            titleVi: 'Trí nhớ',
            bodyEn:
                'In postmenopausal women, 12 weeks of isoflavones improved '
                'memory performance compared with placebo.',
            bodyVi: 'Cải thiện trí nhớ ở phụ nữ sau mãn kinh sau 12 tuần.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/15238592/'),
          ),
          Benefit(
            titleEn: 'Preventing osteoporosis',
            titleVi: 'Phòng loãng xương',
            bodyEn:
                'More than 75 mg a day may significantly improve bone density '
                'in menopausal women, a natural alternative to hormone '
                'therapy.',
            bodyVi: 'Hơn 75 mg/ngày có thể tăng mật độ xương.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/18063230/'),
          ),
          Benefit(
            titleEn: 'Lower prostate-cancer risk',
            titleVi: 'Giảm nguy cơ ung thư tuyến tiền liệt',
            bodyEn:
                'Higher soy-isoflavone intake was linked to up to a 51% lower '
                'risk in high-risk men.',
            bodyVi: 'Giảm tới 51% nguy cơ ở nam giới nguy cơ cao.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/12869409/'),
          ),
          Benefit(
            titleEn: 'Skin health',
            titleVi: 'Tốt cho da',
            bodyEn:
                'As antioxidants and hormone regulators they may slow aging '
                'and improve skin elasticity and firmness.',
            bodyVi: 'Làm chậm lão hóa, tăng đàn hồi da.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/19578653/'),
          ),
          Benefit(
            titleEn: 'Easing PMS',
            titleVi: 'Giảm hội chứng tiền kinh nguyệt',
            bodyEn:
                '68 mg of soy isoflavones daily was linked to fewer '
                'headaches, less breast pain and reduced cramps.',
            bodyVi: '68 mg/ngày giảm đau đầu, đau ngực và co thắt.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/15975174/'),
          ),
        ],
        sourcesEn:
            'Soybeans and soy products (tofu, soy milk, tempeh, soy flour), '
            'edamame, fava beans, chickpeas and lentils; soy is richest in '
            'genistein and daidzein.',
        sourcesVi:
            'Đậu nành và chế phẩm (đậu phụ, sữa đậu nành, tempeh), edamame, '
            'đậu tằm, đậu gà, đậu lăng.',
        sourceFoods: [
          FoodEmoji('🥜', 'Soybeans'),
          FoodEmoji('🥛', 'Soy milk'),
          FoodEmoji('🌱', 'Edamame'),
        ],
      ),
      Compound(
        id: 'i3c',
        name: 'Indole-3-carbinol',
        nameVi: 'Indole-3-carbinol (I3C)',
        emoji: '🥬',
        taglineEn: 'A cruciferous compound that helps balance hormones',
        taglineVi: 'Hợp chất từ rau cải giúp cân bằng nội tiết',
        definitionEn:
            'Indole-3-carbinol (I3C) is a phytochemical from cruciferous '
            'vegetables, formed from glucosinolates when the veg is cut, '
            'chewed and digested. It is studied for hormone regulation, '
            'detoxification and disease prevention — especially its effect on '
            'estrogen metabolism and hormone-related cancers.',
        definitionVi:
            'Indole-3-carbinol (I3C) là hợp chất từ rau họ cải, sinh ra từ '
            'glucosinolate khi nhai và tiêu hóa; được nghiên cứu về điều hòa '
            'nội tiết, thải độc và phòng ung thư liên quan hormone.',
        benefits: [
          Benefit(
            titleEn: 'Hormone regulation',
            titleVi: 'Điều hòa nội tiết',
            bodyEn:
                'It helps convert estrogen into less harmful forms, which may '
                'reduce hormone-imbalance disorders.',
            bodyVi: 'Chuyển estrogen thành dạng ít hại hơn, cân bằng nội tiết.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/9168187/'),
          ),
          Benefit(
            titleEn: 'Anti-cancer properties',
            titleVi: 'Hỗ trợ chống ung thư',
            bodyEn:
                'It may slow some cancer cells and activate detox enzymes that '
                'remove carcinogens (studied in breast and prostate cancer).',
            bodyVi:
                'Làm chậm tế bào ung thư và kích hoạt enzyme thải chất gây '
                'ung thư.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/18314259/'),
          ),
          Benefit(
            titleEn: 'Liver health',
            titleVi: 'Tốt cho gan',
            bodyEn:
                'It supports liver detox pathways so the body clears toxins '
                'more efficiently.',
            bodyVi: 'Hỗ trợ gan thải độc hiệu quả hơn.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/18314259/'),
          ),
          Benefit(
            titleEn: 'Cardiovascular support',
            titleVi: 'Hỗ trợ tim mạch',
            bodyEn:
                'It may lower LDL ("bad") cholesterol and improve circulation.',
            bodyVi: 'Giảm cholesterol xấu (LDL) và cải thiện tuần hoàn.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/22569347/'),
          ),
          Benefit(
            titleEn: 'Reducing inflammation',
            titleVi: 'Giảm viêm',
            bodyEn:
                'Its anti-inflammatory action may lower the risk of long-term '
                'inflammatory disease.',
            bodyVi: 'Kháng viêm, giảm nguy cơ bệnh viêm mạn.',
            source: Source('PubMed', 'https://pubmed.ncbi.nlm.nih.gov/23597448/'),
          ),
        ],
        sourcesEn:
            'Cruciferous vegetables — broccoli, cabbage, cauliflower, Brussels '
            'sprouts, kale and bok choy.',
        sourcesVi:
            'Rau họ cải: bông cải, bắp cải, súp lơ, cải Brussels, cải xoăn, '
            'cải thìa.',
        sourceFoods: [
          FoodEmoji('🥦', 'Broccoli'),
          FoodEmoji('🥬', 'Cabbage'),
          FoodEmoji('🥗', 'Bok choy'),
        ],
      ),
    ],
  ),

  // ═════════════════════════════ BLUE ══════════════════════════════
  RainbowBand(
    id: 'blue',
    nameEn: 'Blue',
    nameVi: 'Xanh dương',
    color: AppColors.blue,
    colorLight: Color(0xFF77BEFF),
    onColor: AppColors.white,
    introEn:
        'Blue foods are packed with anthocyanins — antioxidants for the '
        'brain, heart, eyes and immune system.',
    introVi:
        'Thực phẩm xanh dương giàu anthocyanin — chống oxy hóa cho não, tim, '
        'mắt và miễn dịch.',
    compounds: [
      Compound(
        id: 'genipin',
        name: 'Genipin',
        nameVi: 'Genipin',
        emoji: '🌼',
        iconAsset: 'assets/gardenia.png',
        taglineEn: 'A natural blue-forming compound from gardenia',
        taglineVi: 'Hợp chất tạo màu xanh tự nhiên từ dành dành',
        definitionEn:
            'Genipin is a bioactive iridoid from gardenia fruit (Gardenia '
            'jasminoides). Colorless at first, it turns a deep, stable blue '
            'when it reacts with proteins or amino acids — unlike berry blues, '
            'it stays bright with acid or heat. It also cross-links proteins, '
            'making biological materials stronger, so it is used in biomedical '
            'work (heart valves, tissue scaffolds) as a safer alternative to '
            'toxic cross-linkers.',
        definitionVi:
            'Genipin là iridoid từ quả dành dành; không màu nhưng chuyển xanh '
            'đậm bền khi phản ứng với protein/axit amin. Nó liên kết chéo '
            'protein nên được dùng trong y sinh (van tim, khung mô) an toàn '
            'hơn hóa chất độc.',
        benefits: [
          Benefit(
            titleEn: 'Anti-inflammatory effects',
            titleVi: 'Kháng viêm',
            bodyEn:
                'It may reduce swelling and inflammation, lowering the risk of '
                'chronic inflammatory disease.',
            bodyVi: 'Giảm sưng viêm, hạ nguy cơ bệnh viêm mạn.',
            source: Source('ScienceDirect', 'https://www.sciencedirect.com/science/article/abs/pii/S0014299904005503?via=ihub'),
          ),
          Benefit(
            titleEn: 'Blood-sugar regulation',
            titleVi: 'Điều hòa đường huyết',
            bodyEn:
                'It is being studied for improving insulin secretion and '
                'better blood-sugar control.',
            bodyVi: 'Được nghiên cứu giúp tiết insulin và kiểm soát đường huyết.',
            source: Source('Cell Metabolism', 'https://www.cell.com/cell-metabolism/fulltext/S1550-4131(06)00129-X?_returnURL=https://linkinghub.elsevier.com/retrieve/pii/S155041310600129X?showall=true'),
          ),
          Benefit(
            titleEn: 'Biomedical applications',
            titleVi: 'Ứng dụng y sinh',
            bodyEn:
                'Biocompatible and low-toxicity, it strengthens tissue grafts '
                'and medical implants.',
            bodyVi: 'Tương thích sinh học, gia cố mô ghép và vật liệu cấy.',
            source: Source('ScienceDirect', 'https://www.sciencedirect.com/science/article/abs/pii/S0144861709000526?via=ihub'),
          ),
        ],
        sourcesEn:
            'Gardenia fruit (Gardenia jasminoides) and genipap (Genipa '
            'americana), used to extract genipin for food color, medicine and '
            'biotech.',
        sourcesVi:
            'Quả dành dành và quả genipap — nguồn chiết xuất genipin cho màu '
            'thực phẩm, y học và công nghệ sinh học.',
        sourceFoods: [
          FoodEmoji('🌼', 'Gardenia', imageAsset: 'assets/gardenia.png'),
        ],
      ),
      Compound(
        id: 'anthocyanin_blue',
        name: 'Anthocyanin',
        nameVi: 'Anthocyanin',
        emoji: '🍇',
        taglineEn: 'Flavonoid pigments behind blue foods',
        taglineVi: 'Sắc tố flavonoid tạo màu xanh dương',
        definitionEn:
            'Anthocyanins are flavonoid polyphenols — natural pigments giving '
            'many fruits, vegetables and flowers their blue colors. They are '
            'strong antioxidants; in plants they attract pollinators and '
            'shield tissue from UV and environmental stress.',
        definitionVi:
            'Anthocyanin là polyphenol nhóm flavonoid — sắc tố tạo màu xanh '
            'dương; chất chống oxy hóa mạnh, giúp cây chống tia UV và stress '
            'môi trường.',
        benefits: [
          Benefit(
            titleEn: 'Fighting cancer',
            titleVi: 'Hỗ trợ chống ung thư',
            bodyEn:
                'Their antioxidant, anti-inflammatory action may slow cancer '
                'cells and block signalling behind uncontrolled growth.',
            bodyVi: 'Làm chậm tế bào ung thư và chặn tín hiệu tăng sinh.',
            source: Source('ScienceDirect', 'https://www.sciencedirect.com/science/article/abs/pii/S0271531722000811?via=ihub'),
          ),
          Benefit(
            titleEn: 'Improving cognition',
            titleVi: 'Cải thiện nhận thức',
            bodyEn:
                'They boost antioxidant protection in brain tissue; '
                'anthocyanins from blueberries may protect memory.',
            bodyVi: 'Tăng bảo vệ mô não, hỗ trợ trí nhớ.',
            source: Source('DOI', 'https://doi.org/10.1007/s13668-024-00595-z'),
          ),
          Benefit(
            titleEn: 'Cardiovascular health',
            titleVi: 'Tim mạch',
            bodyEn:
                'They may lower blood pressure, cut heart-attack risk and '
                'improve blood-vessel function.',
            bodyVi: 'Hạ huyết áp, giảm nguy cơ nhồi máu, cải thiện mạch máu.',
            source: Source('DOI', 'https://doi.org/10.3390/nu13082831'),
          ),
          Benefit(
            titleEn: 'Boosting immunity',
            titleVi: 'Tăng miễn dịch',
            bodyEn:
                'They protect lipids and DNA from oxidation and support '
                'balanced cytokine and immune responses.',
            bodyVi: 'Bảo vệ lipid và DNA, cân bằng phản ứng miễn dịch.',
            source: Source('DOI', 'https://doi.org/10.3390/nu15194152'),
          ),
          Benefit(
            titleEn: 'Vision & eye health',
            titleVi: 'Thị lực',
            bodyEn:
                'They protect eye tissue from free radicals and may improve '
                'night vision and overall visual function.',
            bodyVi: 'Bảo vệ mô mắt, cải thiện thị lực ban đêm.',
            source: Source('DOI', 'https://doi.org/10.3390/molecules24183311'),
          ),
          Benefit(
            titleEn: 'Skin protection',
            titleVi: 'Bảo vệ da',
            bodyEn:
                'They strengthen connective tissue and guard skin from '
                'environmental damage and aging.',
            bodyVi: 'Củng cố mô liên kết, bảo vệ da khỏi lão hóa.',
            source: Source('DOI', 'https://doi.org/10.3390/foods13213506'),
          ),
        ],
        sourcesEn:
            'Blueberries, bilberries and blackberries; blue corn and blue '
            'spirulina; and flowers such as butterfly pea, used to color '
            'food and drinks naturally.',
        sourcesVi:
            'Việt quất, dâu tằm xanh, mâm xôi đen; ngô xanh và tảo xoắn xanh; '
            'hoa đậu biếc — dùng tạo màu tự nhiên cho món ăn và đồ uống.',
        sourceFoods: [
          FoodEmoji('🫐', 'Blueberry'),
          FoodEmoji('🌸', 'Butterfly pea'),
        ],
      ),
    ],
  ),

  // ═════════════════════════════ PURPLE ═════════════════════════════
  RainbowBand(
    id: 'purple',
    nameEn: 'Purple',
    nameVi: 'Tím',
    color: AppColors.purple,
    colorLight: Color(0xFFB794FF),
    onColor: AppColors.white,
    introEn:
        'Purple and dark foods are rich in resveratrol and anthocyanins — '
        'antioxidants prized for anti-aging and heart protection.',
    introVi:
        'Thực phẩm màu tím và sẫm màu giàu resveratrol và anthocyanin — '
        'chống oxy hóa nổi bật cho chống lão hóa và bảo vệ tim mạch.',
    compounds: [
      Compound(
        id: 'resveratrol',
        name: 'Resveratrol',
        nameVi: 'Resveratrol',
        emoji: '🍇',
        taglineEn: 'An anti-aging compound from purple grape skin',
        taglineVi: 'Hợp chất chống lão hóa từ vỏ nho tím',
        definitionEn:
            'Resveratrol is a polyphenol produced by plants under stress or '
            'attack (a phytoalexin). It is most concentrated in the skin of '
            'purple grapes, in eggplant and in dark berries, and is a strong '
            'antioxidant studied for its anti-aging and heart-protective '
            'effects.',
        definitionVi:
            'Resveratrol là polyphenol thực vật tạo ra khi cây gặp stress hay '
            'tác nhân gây hại (phytoalexin), tập trung nhiều nhất ở vỏ nho '
            'tím, cà tím và quả mọng sẫm màu; chống oxy hóa mạnh, được nghiên '
            'cứu về khả năng chống lão hóa và bảo vệ tim mạch.',
        benefits: [
          Benefit(
            titleEn: 'Anti-aging',
            titleVi: 'Chống lão hóa',
            bodyEn:
                'It activates cell-defence pathways (such as sirtuins) that '
                'protect cells from oxidative damage linked to aging.',
            bodyVi:
                'Kích hoạt các con đường bảo vệ tế bào (như sirtuin), giúp '
                'chống tổn thương oxy hóa liên quan đến lão hóa.',
          ),
          Benefit(
            titleEn: 'Cardiovascular health',
            titleVi: 'Tim mạch',
            bodyEn:
                'It may relax blood vessels, support healthy blood pressure '
                'and help protect LDL cholesterol from oxidation.',
            bodyVi:
                'Giúp giãn mạch máu, hỗ trợ huyết áp khỏe mạnh và bảo vệ '
                'cholesterol LDL khỏi bị oxy hóa.',
          ),
          Benefit(
            titleEn: 'Protecting cells from free radicals',
            titleVi: 'Bảo vệ tế bào khỏi gốc tự do',
            bodyEn:
                'As a potent antioxidant it neutralises free radicals, '
                'reducing oxidative stress throughout the body.',
            bodyVi:
                'Là chất chống oxy hóa mạnh, trung hòa gốc tự do và giảm '
                'stress oxy hóa trong cơ thể.',
          ),
        ],
        sourcesEn:
            'Purple grape skin and red wine, eggplant, blackberries and '
            'purple cabbage.',
        sourcesVi: 'Vỏ nho tím và rượu vang đỏ, cà tím, mâm xôi đen, bắp cải tím.',
        sourceFoods: [
          FoodEmoji('🍇', 'Purple grapes'),
          FoodEmoji('🍆', 'Eggplant'),
        ],
      ),
      Compound(
        id: 'anthocyanin_purple',
        name: 'Anthocyanin',
        nameVi: 'Anthocyanin',
        emoji: '🍆',
        taglineEn: 'Flavonoid pigments behind purple & dark foods',
        taglineVi: 'Sắc tố flavonoid tạo màu tím và sẫm màu',
        definitionEn:
            'Anthocyanins are flavonoid polyphenols — natural pigments '
            'giving many fruits, vegetables and flowers their deep purple '
            'colors. They are strong antioxidants; in plants they attract '
            'pollinators and shield tissue from UV and environmental stress.',
        definitionVi:
            'Anthocyanin là polyphenol nhóm flavonoid — sắc tố tạo màu tím '
            'đậm; chất chống oxy hóa mạnh, giúp cây chống tia UV và stress '
            'môi trường.',
        benefits: [
          Benefit(
            titleEn: 'Fighting cancer',
            titleVi: 'Hỗ trợ chống ung thư',
            bodyEn:
                'Their antioxidant, anti-inflammatory action may slow cancer '
                'cells and block signalling behind uncontrolled growth.',
            bodyVi: 'Làm chậm tế bào ung thư và chặn tín hiệu tăng sinh.',
            source: Source('ScienceDirect', 'https://www.sciencedirect.com/science/article/abs/pii/S0271531722000811?via=ihub'),
          ),
          Benefit(
            titleEn: 'Improving cognition',
            titleVi: 'Cải thiện nhận thức',
            bodyEn:
                'They boost antioxidant protection in brain tissue; '
                'anthocyanins from purple sweet potato may protect memory.',
            bodyVi: 'Tăng bảo vệ mô não, hỗ trợ trí nhớ.',
            source: Source('DOI', 'https://doi.org/10.1007/s13668-024-00595-z'),
          ),
          Benefit(
            titleEn: 'Cardiovascular health',
            titleVi: 'Tim mạch',
            bodyEn:
                'They may lower blood pressure, cut heart-attack risk and '
                'improve blood-vessel function.',
            bodyVi: 'Hạ huyết áp, giảm nguy cơ nhồi máu, cải thiện mạch máu.',
            source: Source('DOI', 'https://doi.org/10.3390/nu13082831'),
          ),
          Benefit(
            titleEn: 'Skin protection',
            titleVi: 'Bảo vệ da',
            bodyEn:
                'They strengthen connective tissue and guard skin from '
                'environmental damage and aging.',
            bodyVi: 'Củng cố mô liên kết, bảo vệ da khỏi lão hóa.',
            source: Source('DOI', 'https://doi.org/10.3390/foods13213506'),
          ),
        ],
        sourcesEn:
            'Deeply colored produce — eggplant, purple cabbage and purple '
            'sweet potato; grapes, plums, mulberries and figs; and herbs '
            'like lavender and purple basil.',
        sourcesVi:
            'Rau quả màu tím đậm: cà tím, bắp cải tím, khoai lang tím; nho, '
            'mận, dâu tằm, sung; húng tím, oải hương.',
        sourceFoods: [
          FoodEmoji('🍇', 'Grapes'),
          FoodEmoji('🍆', 'Eggplant'),
          FoodEmoji('🥬', 'Purple cabbage'),
        ],
        subtypes: [
          SubCompound(
            name: 'Petunidin',
            definitionEn:
                'An anthocyanidin pigment (an O-methylated derivative of '
                'delphinidin) giving deep blue, purple and red colors; '
                'usually bound to sugars as glycosides for stability.',
            definitionVi:
                'Sắc tố anthocyanidin (dẫn xuất metyl hóa của delphinidin), '
                'tạo màu xanh–tím–đỏ; thường gắn đường thành glycoside cho bền.',
            benefitsEn:
                'Antioxidant — neutralises reactive oxygen species (ROS) and '
                'helps reduce oxidative stress and systemic inflammation.',
            benefitsVi:
                'Chống oxy hóa, dọn gốc oxy phản ứng (ROS), giảm viêm.',
            sourcesEn:
                'Dark-skinned grapes and red wine, and purple tomatoes such '
                'as Indigo Rose.',
            sourcesVi: 'Nho vỏ sẫm, rượu vang đỏ, cà chua tím.',
          ),
          SubCompound(
            name: 'Malvidin',
            definitionEn:
                'A common anthocyanidin in purple and dark fruits and a main '
                'pigment of red wine and purple grapes; fairly stable, turning '
                'red in acid and blue/green in alkaline conditions.',
            definitionVi:
                'Anthocyanidin phổ biến, sắc tố chính của vang đỏ và nho tím; '
                'đỏ trong môi trường axit, xanh/lục trong kiềm.',
            benefitsEn:
                'Antioxidant and anti-inflammatory; supports heart health '
                '(flexible vessels, healthy blood pressure) and may help the '
                'body process glucose.',
            benefitsVi:
                'Chống oxy hóa, kháng viêm, hỗ trợ tim mạch và đường huyết.',
            sourcesEn:
                'Purple grapes and red wine, black rice and black beans, and '
                'flowers such as petunias.',
            sourcesVi: 'Nho tím, vang đỏ, gạo đen, đậu đen, hoa dừa cạn tím.',
          ),
          SubCompound(
            name: 'Procyanidins',
            definitionEn:
                'Polyphenol antioxidants of the flavanol subclass, responsible '
                'for the slightly bitter/astringent taste of grape skin and '
                'dark chocolate; powerful free-radical protectors.',
            definitionVi:
                'Chất chống oxy hóa nhóm flavanol, tạo vị chát của vỏ nho và '
                'socola đen; bảo vệ tế bào khỏi gốc tự do.',
            benefitsEn:
                'Support heart health by relaxing and widening vessels; '
                'protect skin collagen (anti-aging) and may aid cognition '
                'with age.',
            benefitsVi:
                'Giãn mạch tốt cho tim, bảo vệ collagen da, hỗ trợ trí não.',
            sourcesEn:
                'Dark chocolate and cocoa, grape seeds, red wine and purple '
                'grapes.',
            sourcesVi: 'Socola đen, ca cao, hạt nho, vang đỏ, nho tím.',
          ),
          SubCompound(
            name: 'Delphinidin',
            definitionEn:
                'An anthocyanidin giving deep blue and purple colors; like '
                'others it turns red in acid and blue/purple in neutral or '
                'alkaline conditions.',
            definitionVi:
                'Anthocyanidin tạo màu xanh–tím; đỏ trong axit, xanh/tím '
                'trong trung tính–kiềm.',
            benefitsEn:
                'Supports heart health (relaxes vessels), is anti-inflammatory, '
                'may help the body process glucose and protects skin from UV '
                'damage.',
            benefitsVi:
                'Giãn mạch, kháng viêm, hỗ trợ đường huyết, bảo vệ da khỏi UV.',
            sourcesEn:
                'Eggplant skin and purple cabbage, and flowers such as '
                'hibiscus.',
            sourcesVi: 'Vỏ cà tím, bắp cải tím, hoa dâm bụt.',
          ),
        ],
      ),
    ],
  ),
];

/// Look up a rainbow band by its id (falls back to the first band).
RainbowBand bandById(String id) =>
    kBands.firstWhere((b) => b.id == id, orElse: () => kBands.first);
