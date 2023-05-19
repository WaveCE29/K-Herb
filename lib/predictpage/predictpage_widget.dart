import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'predictpage_model.dart';
import 'dart:typed_data';
export 'predictpage_model.dart';
import 'package:image/image.dart' as img;

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PredictpageWidget extends StatefulWidget {
  const PredictpageWidget({
    Key? key,
    this.urlImages,
  }) : super(key: key);

  final String? urlImages;

  @override
  _PredictpageWidgetState createState() => _PredictpageWidgetState();
}

class _PredictpageWidgetState extends State<PredictpageWidget>
    with TickerProviderStateMixin {
  late PredictpageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String uploadedImage = "";
  List<String> result = [];
  List<String> labels_TH = [
    "ว่านหางจระเข้",
    "บีทรูท",
    "บอระเพ็ด",
    "น้ำเต้า",
    "ดอกอัญชัน",
    "กะหล่ำปลี",
    "ขี้เหล็ก",
    "ขึ้นฉ่าย",
    "ชะอม",
    "ชะพลู",
    "ไชยา",
    "แตงกวา",
    "ดอกแค",
    "ดอกโสน",
    "ฟ้าทะลายโจร",
    "กระเทียม",
    "ขิง",
    "บัวบก",
    "โหระพา",
    "หญ้าหวาน",
    "ข่า",
    "คะน้า",
    "ขมิ้น",
    "กะเพรา",
    "ใบมะนาว",
    "ตะไคร้",
    "มะกรูด",
    "ใบมะขาม",
    "มะรุม",
    "แมงลัก",
    "ใบหม่อน",
    "พริกไทย",
    "ผักขม",
    "ผักชีฝรั่ง",
    "พญาสัตบรรณ",
    "เพชรสังฆาต",
    "พลู",
    "เงาะ",
    "สาบเสือ",
    "สะระแหน่",
    "เสลดพังพอน",
    "หอมแดง",
    "โสม",
    "อ้อย",
    "ถั่วลั่นเตา",
    "ตำลึง",
    "เตย",
    "ทับทิม",
    "แตงโม",
    "ย่านาง"
  ];
  List<String> labels = [
    "Aloe",
    "Beetroot",
    "Boraphed",
    "Bottle-gourd",
    "Butterfly pea",
    "Cabbage",
    "Cassia",
    "Celery",
    "Cha-om",
    "Chaplu",
    "Chauya",
    "Cucumber",
    "Dok-Khae",
    "Dok-Son",
    "Fahthalinejol",
    "Garlic",
    "Ginger",
    "Gotu kola",
    "Horapa",
    "Hya-hwan",
    "Kha",
    "Kha-na",
    "Khamin",
    "Krapao",
    "Lemon",
    "Lemongrass",
    "Magrud",
    "Makham",
    "Marum",
    "Meanglak",
    "Mulberry",
    "Pepper",
    "Phak-khom",
    "Phakchi-Frang",
    "Phaya-Sattabun",
    "Phechrsangkhat",
    "Plu",
    "Rambutan",
    "Sabtiger",
    "Saranae",
    "Seldphangphon",
    "Shallot",
    "Som",
    "Sugar-cane",
    "Sweet peas",
    "Tamlung",
    "Tey",
    "Thabthim",
    "Watermelon fruit real",
    "Yanang"
  ];

  var object_test = [
    {
      "id": 1,
      "name_th": "ว่านหางจระเข้",
      "name_eng": "Aloe",
      "category": "Leaves",
      "properties_th":
          "1. วุ้นของว่านหางจระเข้สามารถใช้สมานแผล และห้ามเลือดได้ ทำให้แผลหายไว\n2. ใช้รักษาอาการติดเชื้อ อักเสบ และกระตุ้นเซลล์เนื้อเยื่อต่างๆ ให้เติบโต\n3. ใช้รักษาแผลที่เกิดจากความร้อน เช่น ไฟไหม้ น้ำร้อนลวก และการฉายรังสี\n4. ใช้แก้พิษแมงกะพรุน ช่วยบรรเทาอาการแสบร้อนจากพิษ\n5. มีสรรพคุณทางยาในการช่วยประสานกระดูก และช่วยบำรุงข้อกระดูก\n6. นำมาปอกเปลือก ล้างเมือกออก ต้มน้ำใช้เป็นยาระบาย ยาแก้ไอ และยาแก้เจ็บคอ\n7. นำมาทำเป็นเครื่องดื่มเพื่อสุขภาพ สำหรับควบคุมระดับน้ำตาลของผู้ป่วยเบาหวาน\n8. เนื้อว่านหางจระเข้บรรเทาอาการปวดฟันได้ ตัดเป็นชิ้นเล็กๆ เหน็บตามซอกฟัน \n9. รักษาอาการผิวไหม้แสบร้อนจากแสงแดด และใช้ทารักษาฝ้าบนใบหน้าได้ด้วย\n10. ตัดเนื้อวุ้นเป็นแท่งเล็กๆ นำไปแช่เย็น แล้วเหน็บทวารหนัก ช่วยรักษาริดสีดวงทวารได้",
      "properties_eng":
          "1. Aloe vera jelly can be used to heal wounds. and stop the bleeding make the wound heal quickly\n2. Used to treat infection, inflammation and stimulate tissue cells to grow.\n3. Used to treat wounds caused by heat such as burns, scalds and radiation.\n4. Used to cure jellyfish poisoning Helps relieve burning sensation from poisoning.\n5. It has medicinal properties to help harmonize the bones. and helps nourish joints\n6. Peeled, washed off mucus, boiled in water, used as a laxative, cough medicine and sore throat remedy.\n7. Used to make a healthy drink for controlling sugar levels of diabetic patients\n8. Aloe vera pulp relieves toothache. cut into small pieces tuck between the teeth\n9. Treatment of sunburned skin and can be used to treat blemishes on the face as well\n10. Cut the agar-agar into small sticks, refrigerate and then suppository against the anus. Helps to treat hemorrhoids",
      "url_img": "assets/images/aloe.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%a7%e0%b9%88%e0%b8%b2%e0%b8%99%e0%b8%ab%e0%b8%b2%e0%b8%87%e0%b8%88%e0%b8%a3%e0%b8%b0%e0%b9%80%e0%b8%82%e0%b9%89\/"
    },
    {
      "id": 2,
      "name_th": "ดอกอัญชัน",
      "name_eng": "Butterfly pea",
      "category": "Flower",
      "properties_th":
          "1.น้ำอัญชันมีส่วนช่วยต่อต้านอนุมูลอิสระในร่างกาย \n2.เครื่องดื่มน้ำอัญชันช่วยเสริมสร้างภูมิต้านทานให้ร่างกายและเพิ่มพลังงานให้ร่างกาย \n3.มีส่วนช่วยในการชะลอวัยและริ้วรอยแห่งวัย \n4.ดอกมีส่วนช่วยในการบำรุงสมอง \n5.เพิ่มการไหลเวียนเลือด \n6.ดอกอัญชันมีฤทธิ์ในการละลายลิ่มเลือด \n7.ช่วยป้องกันโรคเส้นเลือดสมองตีบ \n8.ช่วยรักษาอาการผมร่วง (ดอก) \n9.อัญชันทาคิ้ว ทาหัว ใช้เป็นยาปลูกผม \n10.ปลูกขนช่วยให้ดกดำเงางามยิ่งขึ้น (น้ำคั้นจากดอก) \n11.ช่วยลดความเสี่ยงจากการเกิดเส้นเลือดอุดตัน \n12.ช่วยลดความเสี่ยงของการเกิดโรคหัวใจและหลอดเลือดหัวใจอุดตัน \n13.ช่วยลดความเสี่ยงจากการเกิดโรคมะเร็งด้วยสารต้านอนุมูลอิสระ \n14.ช่วยลดระดับน้ำตาลในเลือดของผู้ป่วยที่เป็นโรคเบาหวาน \n15.อัญชันมีคุณสมบัติในการช่วยล้างสารพิษและของเสียออกจากร่างกาย \n16.ช่วยบำรุงสายตา แก้อาการตาฟาง ตาแฉะ (น้ำคั้นจากดอกสดและใบสด) \n17.ช่วยป้องกันโรคต้อกระจก ต้อหิน ตาเสื่อมจากโรคเบาหวาน (ดอก) \n18.ช่วยเพิ่มความสามารถในการมองเห็นให้ดียิ่งขึ้น \n19.นำรากไปถูกับน้ำฝน นำมาใช้หยอดตาและหู (ราก) \n20.ใช้เป็นยาระบาย แต่อาจทำให้คลื่นไส้อาเจียนได้ (เมล็ด) ",
      "properties_eng":
          "1. Butterfly pea juice helps fight free radicals in the body.\n2. Butterfly pea juice drinks help strengthen the body's immunity and increase energy for the body.\n3. Contributes to anti-aging and aging wrinkles\n4. Flowers help to nourish the brain.\n5. Increase blood circulation\n6. Butterfly pea flowers have the ability to dissolve blood clots.\n7. Help prevent ischemic stroke\n8. Help treat hair loss (flowers).\n9. Butterfly pea paint on the head, used as a hair transplant\n10. Growing hair helps to make it more shiny. (squeezed juice from flowers)\n11. Help reduce the risk of blood clots.\n12. Help reduce the risk of heart disease and coronary heart disease.\n13. Help reduce the risk of cancer with antioxidants.\n14. Help reduce blood sugar levels of patients with diabetes.\n15. Butterfly pea has the ability to help flush out toxins and waste from the body.\n16. Help nourish eyesight. Relieve blurred vision, wet eyes (juice from fresh flowers and fresh leaves)\n17. Help prevent cataracts, glaucoma, eye degeneration from diabetes (flowers).\n18. Improves the ability to see better.\n19. Rub the roots with rainwater. Used for eye and ear drops (root).\n20. Use it as a laxative. but may cause nausea and vomiting (seeds)",
      "url_img": "assets/images/Butterfly pea.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%ad%e0%b8%b1%e0%b8%8d%e0%b8%8a%e0%b8%b1%e0%b8%99\/"
    },
    {
      "id": 3,
      "name_th": "ชะอม",
      "name_eng": "Cha-om",
      "category": "Leaves",
      "properties_th":
          "1. ชะอมอุดมด้วยวิตามินเอ หากจะตามหาผักที่มีวิตามินเอสูงต้องห้ามมองข้ามชะอมเลยนะ เพราะอุดมด้วยวิตามินเอที่จะช่วยให้เราต่อสู้กับอนุมูลอิสระทั้งจากปัจจัยภายนอกและภายในได้อย่างมีประสิทธิภาพ และยังช่วยบำรุงสายตาด้วย\n2. ยอดอ่อนของชะอมมีสรรพคุณช่วยลดความร้อนในร่างกาย ซึ่งเป็นส่วนที่เรามักนำมาทำอาหารกินกันมากที่สุด\n3. ชะอมมีเส้นใยอาหารที่มีประโยชน์ต่อระบบขับถ่าย ทำให้การขับถ่ายเป็นปกติ แก้อาการท้องผูก\n4. ประโยชน์ของชะอมช่วยขับลมในกระเพาะอาหารและลำไส้ บรรเทาอาการปวดท้องหรือปวดเสียวในท้องได้ดี แก้อาการท้องอืดและท้องเฟ้อ\n5. ชะอมช่วยบำรุงเส้นเอ็น อีกหนึ่งสรรพคุณที่โดดเด่นของชะอมคือ ช่วยบำรุงและรักษาเส้นเอ็นให้แข็งแรง ไม่เสื่อมเร็วกว่าที่ควร\n6. ชะอมมีแคลเซียมสูง ซึ่งมีความสำคัญต่อกระดูกและฟัน โดยเฉพาะในผู้หญิงวัยทองที่มีความเสี่ยงจะเกิดภาวะกระดูกพรุนได้ง่าย ถ้าอยากให้กระดูกและฟันแข็งแรงก็ต้องกินชะอมเป็นประจำ\n7. ชะอมมีคุณสมบัติช่วยรักษาอาการลิ้นอักเสบและเป็นผื่นแดง\n8. ในชะอมมีฟอสฟอรัส ที่ทำหน้าที่ช่วยเสริมให้วิตามินบีต่างๆ ทำงานได้อย่างเต็มประสิทธิภาพ\n9. ชะอมมีธาตุเหล็ก ที่มีส่วนสำคัญในการช่วยบำรุงเลือด ทำให้การไหลเวียนของเลือดเป็นไปอย่างปกติ\n10. ชะอมช่วยเสริมสร้างระบบของภูมิคุ้มกันในร่างกายให้แข็งแรง ทำให้กำจัดเชื้อโรคต่างๆ ได้ดีขึ้น ไม่เจ็บป่วยง่าย เพราะฤทธิ์ของวิตามินซีที่มีอยู่มากในชะอม\n11. ประโยชน์ของชะอมช่วยต่อต้านการเกิดโรคมะเร็ง และลดโอกาสที่จะเกิดโรคหัวใจได้ด้วย เนื่องจากในชะอมมีสารสำคัญที่ชื่อว่า เบต้าแคโรทีน\n12. สารเบต้าแคโรทีนในชะอมยังช่วยบำรุงผิวพรรณให้ผ่องใส แลดูอ่อนเยาว์ และป้องกันความแก่ก่อนวัย\n13. ชะอมมีสรรพคุณช่วยบำรุงเส้นผม ที่แห้งแตกปลาย ไม่มีน้ำหนัก ให้กลับมานุ่มสลวยได้\n14. รากชะอมมีสรรพคุณแก้ท้องอืด ท้องเฟ้อได้ อีกทั้งการกินชะอมยังช่วยในการขับลมในกระเพาะและลำไส้ได้",
      "properties_eng":
          "1. Cha-om is rich in vitamin A. If you are looking for vegetables that are high in vitamin A, you must not overlook cha-om. Because it is rich in vitamin A that will help us fight free radicals from both external and internal factors effectively. and also helps nourish eyesight\n2. Cha-om young shoots have properties that help reduce body heat. which is the part that we usually use to cook and eat the most\n3. Cha-om contains dietary fiber that is beneficial to the digestive system. make excretion normal relieve constipation\n4. The benefits of acacia help expel gas in the stomach and intestines. Relieves abdominal pain or pain in the stomach as well. Relieve flatulence and flatulence\n5. Cha-om helps nourish tendons. Another outstanding property of cha-om is Helps nourish and maintain strong tendons Doesn't deteriorate faster than it should\n6. Cha-om is high in calcium. which is important for bones and teeth Especially in postmenopausal women who are at risk of developing osteoporosis easily. If you want your bones and teeth to be strong, you need to eat acacia regularly.\n7. Cha-om has properties to help treat inflammation and redness of the tongue.\n8. There is phosphorus in acacia. that acts to help supplement various B vitamins Work at full efficiency\n9. Cha-om contains iron. that play an important role in helping to nourish the blood make the blood flow normal\n10. Cha-om helps strengthen the immune system in the body. Makes getting rid of various germs better, not easily sick Because of the effect of vitamin C that is abundant in cha-om\n11. The benefits of cha-om help fight cancer. and reduce the chance of heart disease as well Because in cha-om there is an important substance called beta-carotene\n12. Beta-carotene in cha-om also helps nourish the skin to be bright. looking young and prevent premature aging\n13. Cha-om has properties to help nourish hair. Dry, split ends, no weight, can return to be soft and flowing.\n14. Cha-om root has properties to cure flatulence and flatulence, and eating cha-om also helps to expel gas in the stomach and intestines.",
      "url_img": "assets/images/Cha-om.jpg",
      "url": "https:\/\/medthai.com\/%e0%b8%8a%e0%b8%b0%e0%b8%ad%e0%b8%a1\/"
    },
    {
      "id": 4,
      "name_th": "ไชยา ",
      "name_eng": "Chaya",
      "category": "Leaves",
      "properties_th":
          "1.มีสารต้านอนุมูลอิสระ\n2.ช่วยในการหมุนเวียนโลหิต\n3.ช่วยย่อยอาหาร\n4.ช่วยในการมองเห็น\n5.บำรุงสายตา\n6.รักกษาโรคหอบหืด\n7.ช่วยลดคอเลสเตอรอล\n8.ช่วยบรรเทาริดสีดวงทวาร\n9.ช่วยลดน้ำหนัก\n10.ป้องกันอาการไอ\n11.ล้างพิษในตับ\n12.ป้องกันอาการปวดหัว\n13.เพิ่มแคลเซียมให้กระดูก\n14.รักษาโรคกระดูกพรุน\n15.ลดการสะสมและลดการติดเชื้อในปอด\n16.ป้องกันโลหิตจางโดยเพิ่มธาตุเหล็กให้กับเลือด\n17.ควบคุมระดับน้ำตาลให้ผู้ป่วยโรคเบาหวาน\n18.ช่วยบรรเทาโรคไขข้ออักเสบ\n19.ปรับสมดุลของระบบการเผาผลาญ\n20.ลดการอักเสบในเส้นเลือด",
      "properties_eng":
          "1. Contains antioxidants\n2. Helps in blood circulation\n3. Help digestion\n4. helps to see\n5. Eye care\n6. Treat asthma\n7. Help reduce cholesterol.\n8. Help relieve hemorrhoids.\n9. Help lose weight.\n10. Prevent coughing.\n11. detoxify the liver\n12. Prevent headaches.\n13. Add calcium to bones.\n14. Treat osteoporosis.\n15. Reduce accumulation and reduce lung infections.\n16. Prevent anemia by adding iron to the blood.\n17. Control sugar levels for diabetics.\n18. Help relieve rheumatoid arthritis.\n19. Balancing the metabolic system.\n20. Reduce inflammation in blood vessels.",
      "url_img": "assets/images/chaya.jpg",
      "url": "https:\/\/mthai.com\/lifestyle\/health\/45002.html"
    },
    {
      "id": 5,
      "name_th": "กระเทียม",
      "name_eng": "Garlic",
      "category": "Fruit",
      "properties_th":
          "1.ช่วยบำรุงผิวหนังให้มีสุขภาพดีและแข็งแรง \n2.ช่วยเสริมสร้างการเจริญเติบโตของเนื้อเยื่อในร่างกาย \n3.ช่วยป้องกันการเกิดโรคมะเร็ง \n4.ช่วยเสริมสร้างภูมิต้านทานให้แก่ร่างกาย \n5.ช่วยลดระดับคอเลสเตอรอลและน้ำตาลในเลือด \n6.ช่วยปรับสมดุลในร่างกาย \n7.ช่วยแก้อาการวิงเวียนศีรษะ อาการมึนงง ปวดศีรษะ หูอื้อ \n8.ช่วยในเรื่องระบบสืบพันธุ์และระบบทางเดินปัสสาวะ เพราะมีสารที่ช่วยควบคุมฮอร์โมนทั้งหญิงและชาย \n9.ช่วยทำให้มดลูกบีบตัว \n10.เพิ่มพละกำลังให้มีเรี่ยวแรง \n11.ช่วยรักษาโรคความดันโลหิต \n12.ช่วยป้องกันการเกิดโรคหัวใจ \n13.ลดความเสี่ยงของหัวใจล้มเหลวเฉียบพลัน \n14.ช่วยต่อต้านเนื้องอก \n15.ช่วยแก้ปัญหาผมบาง ยาวช้า มีสีเทา \n16.ช่วยป้องกันการเกิดและรักษาโรคโลหิตจาง \n17.ช่วยในการขับพิษและสารพิษอันตรายที่ปนเปื้อนในเม็ดเลือด \n18.ช่วยป้องกันผนังหลอดเลือดหนาและแข็งตัว \n19.สารสกัดน้ำมันกระเทียมมีสารที่มีส่วนช่วยในการละลายลิ่มเลือด \n20.ช่วยป้องกันการเกิดเส้นเลือดอุดตัน ",
      "properties_eng":
          "1. Help nourish skin to be healthy and strong.\n2. Help strengthen the growth of tissues in the body.\n3. Help prevent cancer.\n4. Help strengthen the immune system for the body.\n5. Help reduce cholesterol and blood sugar levels.\n6. Help balance the body.\n7. Helps to relieve dizziness, dizziness, headache, tinnitus.\n8. Helps with the reproductive system and the urinary system. because there are substances that help regulate both female and male hormones\n9. Helps make the uterus contract.\n10. Increase strength to have strength.\n11. Help cure blood pressure disease.\n12. Help prevent heart disease.\n13. Reduce the risk of acute heart failure.\n14. Help against tumors.\n15. Help solve the problem of thin, long, slow, gray hair.\n16. Help prevent birth and cure anemia.\n17. Helps to detoxify and dangerous toxins contaminated in blood cells.\n18. Help prevent thick and hardened blood vessel walls.\n19. Garlic oil extract contains substances that help dissolve blood clots.\n20. Help prevent blood clots.",
      "url_img": "assets/images/Garlic.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%81%e0%b8%a3%e0%b8%b0%e0%b9%80%e0%b8%97%e0%b8%b5%e0%b8%a2%e0%b8%a1\/"
    },
    {
      "id": 6,
      "name_th": "ใบหม่อน",
      "name_eng": "Mulberry",
      "category": "Leaves",
      "properties_th":
          "1.ใบหม่อนมีรสจืดเย็น ใช้ต้มกับน้ำดื่มเป็นยาระงับประสาท \n2.ใบใช้ทำชามีฤทธิ์ต้านอนุมูลอิสระ \n3.กิ่งหม่อนมีสรรพคุณช่วยทำให้เลือดลมไหลเวียนได้สะดวกมากขึ้น \n4.ช่วยแก้อาการปวดศีรษะ\n5.ผลนำมาต้มกับน้ำหรือเชื่อมกินเป็นยาแก้ธาตุไม่ปกติ \n6.ผลหม่อนมีรสเปรี้ยวหวานเย็น มีสรรพคุณช่วยดับร้อน คายความร้อนรุ่ม ขับลมร้อน ทำให้ชุ่มคอ บรรเทาอาการกระหายน้ำ และทำให้ร่างกายชุ่มชื่น \n7.ใบใช้ต้มกับน้ำดื่มเป็นยาแก้ไข้ ไข้หวัด ตัวร้อน แก้ร้อนในกระหายน้ำ และเป็นยาช่วยขับลมร้อน \n8.ใบมีรสขม หวานเล็กน้อย เป็นยาเย็นออกฤทธิ์ต่อปอด ตับ และกระเพาะอาหาร ใช้เป็นยาแก้ไอร้อนเนื่องจากถูกลมร้อนกระทบ\n9.ใบมีสรรพคุณช่วยขับเหงื่อ \n10.ใช้ต้มกับน้ำดื่มเป็นยาแก้ไอ \n11.เปลือกรากหม่อนมีรสชุ่ม เป็นยาเย็นออกฤทธิ์ต่อปอดและม้าม ใช้เป็นยาแก้ไอเป็นเลือด แก้ไอร้อนไอหอบ \n12.เมล็ดมีสรรพคุณเป็นยาขับเสมหะ \n13.ใบนำมาทำเป็นยาต้ม ใช้อมหรือกลั้วคอแก้อาการเจ็บคอ คอแห้ง แก้ไอ และทำให้เนื้อเยื่อชุ่มชื้น หล่อลื่นภายนอก \n14.รากนำมาตากแห้งต้มผสมกับน้ำผึ้ง มีรสหวานเย็น ใช้มากในโรคทางเดินหายใจและการมีน้ำสะสมในร่างกายอย่างผิดปกติ \n15.ยอดหม่อนนำมาต้มกับน้ำดื่มและล้างตาเป็นยาบำรุงตา \n16.ส่วนผลมีสรรพคุณทำให้เส้นประสาทตาดี ทำให้สายตาแจ่มใส ร่างกายสุขสบาย \n17.ใบนำมาต้มเอาน้ำใช้ล้างตา แก้ตาแดง ตามัว ตาแฉะ และตาฝ้าฟาง \n18.ใบมีสรรพคุณช่วยทำให้เลือดเย็นและตาสว่าง \n19.ส่วนผลมีสรรพคุณช่วยทำให้หูตาสว่าง \n20.ใบแก่นำมาตากแห้งมวนสูบเหมือนบุหรี่ แก้ริดสีดวงจมูก",
      "properties_eng":
          "1. Mulberry leaves are tasteless and cool. Used boiled with drinking water as a sedative.\n2. Leaves used to make tea have antioxidant effects.\n3. Mulberry branches have properties that help make the blood flow more easily.\n4. Helps to relieve headaches.\n5. The results are boiled with water or eaten as an antidote to abnormal elements.\n6. Mulberry fruit has a sour, sweet, cool taste. It has the properties to help extinguish the heat. Dissipates heat, expels hot air, moistens the throat, relieves thirst and hydrates the body\n7. The leaves are used to boil with drinking water as a remedy for fever, flu, heat, and thirst. and is a medicine to help expel hot air\n8. The leaves are bitter, slightly sweet, a cold medicine that acts on the lungs, liver and stomach. Used as a hot cough remedy due to being affected by hot air.\n9. Leaves have properties that help drive sweat.\n10. Boil with drinking water as a cough remedy.\n11. Mulberry root bark has a moist taste. It is a cold medicine that acts on the lungs and spleen. Used as a cough syrup cure hot cough, panting cough\n12. Seeds have properties as an expectorant.\n13. The leaves are used to make a decoction. Suck on or gargle for sore throats, dry throats, coughs, and to moisten tissues. external lubrication\n14. The roots are dried, boiled, mixed with honey, have a sweet, cool taste, used in respiratory diseases and abnormal accumulation of water in the body.\n15. Mulberry shoots are boiled with drinking water and eyewash as an eye tonic.\n16. As for the fruit, there are properties that make the optic nerve good. clear eyesight comfortable body\n17. The leaves are boiled with water to wash the eyes to cure red eyes, blurry eyes, wet eyes and cloudy eyes.\n18. leaves have properties that help cool blood and brighten eyes.\n19. As for the fruit, there are properties that help brighten the ears and eyes.\n20. Old leaves are dried and smoked like cigarettes. Cure nasal polyps",
      "url_img": "assets/images/Mulberry.jpg",
      "url":
          "https:\/\/medthai.com\/%E0%B8%AB%E0%B8%A1%E0%B9%88%E0%B8%AD%E0%B8%99\/"
    },
    {
      "id": 7,
      "name_th": "ใบมะขาม",
      "name_eng": "Tamarind",
      "category": "Leaves",
      "properties_th":
          "1.มะขามช่วยเสริมสร้างภูมิต้านทานโรคให้แก่ร่างกายด้วยสารต่อต้านอนุมูลอิสระ \n2.ช่วยบำรุงผิวพรรณให้เปล่งปลั่งสดใสด้วยวิตามินซีจากมะขาม \n3.ช่วยในการชะลอวัยและการเกิดริ้วรอยแห่งวัย \n4.แคลเซียมจากมะขามจะช่วยบำรุงกระดูกและฟันให้แข็งแรง \n5.มะขามมีธาตุเหล็ก ซึ่งมีส่วนช่วยในการสร้างเม็ดเลือด \n6.ใช้ในการทำทรีตเม้นต์ด้วยการนำมาขัดตามซอกขาหนีบ รักแร้ ข้อพับ ซึ่งจะช่วยลดรอยคล้ำลงได้ \n7.นำมะขามเปียกไปแช่น้ำ ลอกเอาใยออก นำมะขามมาถูตัวเบา ๆ ช่วยให้ผิวหนังชุ่มชื่นตลอดทั้งวัน และช่วยกำจัดแบคทีเรียได้อย่างมีประสิทธิภาพอีกด้วย มะขามเปียกและดินสอพองผสมจนเข้ากัน นำมาพอกหน้าทิ้งไว้ประมาณ 20 นาทีแล้วล้างออก จะช่วยให้ผิวหน้าดูกระชับสดใสและสะอาดยิ่งขึ้น \n8.มะขามเปียกผสมกับน้ำอุ่นและนมสด ใช้พอกผิว ช่วยให้ผิวหนังที่มีรอยดำคล้ำกลับมาขาวสดใส นุ่มนวลยิ่งขึ้น \n9.นำมาใช้เป็นส่วนผสมหรือใช้ทำเป็นกรดผลไม้ (AHA) \n10.สำหรับผู้ที่ดื่มกาแฟหรือสูบบุหรี่เป็นประจำ ให้นำเนื้อมะขามมาขัดถูฟันเป็นประจำทุกครั้งที่แปรงฟัน จะช่วยขจัดคราบสกปรกบริเวณฟันลงได้ \n11.สามารถนำมาใช้ทำยานวดผม ซึ่งช่วยรักษารากผม ฆ่าเชื้อราบนหนังศีรษะ และช่วยฆ่าเหาได้อีกด้วย ด้วยการนำมะขามเปียกมาผสมกับน้ำแล้วใช้มือคั้นเนื้อมะขามเพื่อให้ละลายออกมาผสมกับน้ำ น้ำที่ได้นั้นจะมีลักษณะเหลว (ไม่ควรเหลวมาก) แล้วนำมานวดศีรษะหลังจากที่สระผมเสร็จแล้ว ทิ้งไว้ประมาณ 30 นาทีแล้วล้างออก \n12.ใช้ทำเป็นน้ำยาอาบน้ำ ด้วยการนำใบมะขามมาจำนวนหนึ่ง ใส่ใบมะขามลงในน้ำเดือดแล้วปิดฝา แล้วเคี่ยวประมาณ 30 นาที จากนั้นนำลงจากเตาปล่อยให้เย็นแล้วนำมาอาบ จะช่วยให้ผิวพรรณดีขึ้น รักษาผดผื่นคันตามร่างกายและผิวหนังได้ \n13.ช่วยป้องกันการเกิดและช่วยรักษาโรคเลือดออกตามไรฟัน มะขามมีวิตามินเอที่มีส่วนช่วยในการบำรุงและรักษาสายตา \n14.ช่วยลดความร้อนในร่างกายได้เป็นอย่างดี \n15.แก้อาการท้องผูกด้วยการใช้เนื้อมะขามเปียกประมาณ 15 ฝัก นำมาจิ้มกับเกลือแล้วรับประทาน หรือใส่เกลือเติมน้ำแล้วคั้นเป็นน้ำดื่ม \n16.แก้อาการท้องเดินด้วยการใช้เปลือกต้นประมาณ 2 กำมือ นำมาต้มกับน้ำปูนใสหรือน้ำแล้วนำมารับประทาน \n17.ช่วยถ่ายพยาธิตัวกลมในลำไส้ พยาธิไส้เดือน ด้วยการใช้เมล็ดมะขามมาคั่ว กะเทาะเปลือกออก \n18.นำเนื้อในเมล็ดมาแช่น้ำเกลือจนนิ่ม แล้วรับประทานครั้งละ 20 เม็ด\n19.ช่วยขับเสมหะ ละลายเสมหะ ด้วยการนำมะขามเปียกมาจิ้มเกลือแล้วรับประทาน\n20.ใบสดมะขามช่วยรักษาหวัด อาการไอ",
      "properties_eng":
          "1. Tamarind helps strengthen the body's immune system with anti-oxidants.\n2. Help nourish your skin to be radiant with vitamin C from tamarind.\n3. Helps to slow down aging and aging.\n4. Calcium from tamarind will help maintain strong bones and teeth.\n5. Tamarind contains iron which contributes to the formation of hematopoietic\n6. Used to do treatment by scrubbing along the groin, armpits, crooked joints, which can help reduce dark circles.\n7. Soak the tamarind in water, peel off the fibers, gently rub the tamarind to help keep the skin moisturized throughout the day. and effectively eliminates bacteria as well Tamarind and chalk mix until combined. Bring the mask and leave it for about 20 minutes, then rinse. It will help the skin look firmer, brighter and cleaner.\n8. Tamarind mixed with warm water and fresh milk to mask the skin, help the skin with dark spots to return to bright white. softer\n9. Used as an ingredient or used to make fruit acids (AHA).\n10. For those who regularly drink coffee or smoke To bring tamarind pulp to scrub your teeth regularly every time you brush your teeth. Will help remove stains on the teeth down.\n11. Can be used to make a hair conditioner. which helps maintain hair roots kill fungus on scalp and help kill head lice as well By bringing wet tamarind mixed with water and then squeeze the tamarind pulp by hand to dissolve and mix with water. The resulting water will look liquid. (Shouldn't be very liquid) and massage the head after washing your hair. Leave it for about 30 minutes and then wash it off.\n12. Used to make a bath solution. with the introduction of a number of tamarind leaves Put tamarind leaves in boiling water and close the lid. Then simmer for about 30 minutes, then take it down from the oven, let it cool and take a bath. It will help make your skin better. Treat rashes on the body and skin.\n13. Help prevent birth and help cure scurvy. Tamarind contains vitamin A that helps to nourish and maintain eyesight.\n14. It helps reduce body heat very well.\n15. Relieve constipation by using about 15 tamarind pods, dipping them with salt and eating. or add salt, add water and squeeze into drinking water\n16. Cure diarrhea by using about 2 handfuls of bark, boiled with lime water or water and then eaten.\n17. Help take roundworms in the intestine. roundworm by using tamarind seeds to roast peel off\n18. Bring the meat in the seeds to soak in salt water until soft. then take 20 tablets at a time\n19. Help expel phlegm, dissolve phlegm by dipping tamarind with salt and eating.\n20. Fresh tamarind leaves help treat colds, coughs.",
      "url_img": "assets/images/Tamarind.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%a1%e0%b8%b0%e0%b8%82%e0%b8%b2%e0%b8%a1\/"
    },
    {
      "id": 8,
      "name_th": "ถั่วลันเตา",
      "name_eng": "Sweet peas",
      "category": "Fruit",
      "properties_th":
          "1.ยอดของถั่วลันเตามีเบตาแคโรทีนสูง ซึ่งช่วยในการบำรุงสายตาและผิวพรรณ \n2.ใช้บำบัดโรคเบาหวาน ผู้ป่วยที่เป็นโรคเบาหวานควรรับประทานเป็นประจำด้วยการใช้ฝักอ่อนสดนำมาล้างน้ำให้สะอาดและนำไปต้มจนสุก แล้วนำมารับประทานเป็นประจำ\n3.ช่วยลดระดับคอเลสเตอรอลในเลือด\n4.เมล็ดช่วยบำรุงไขมัน\n5.ถั่วลันเตาอุดมไปด้วยวิตามินบี วิตามินบี 12 และสารเลซิทิน (Lecithin) ซึ่งจำเป็นต่อการทำงานของระบบประสาทมาก จึงช่วยป้องกันอาการขี้หลงขี้ลืมได้\n6.ช่วยรักษาโรคหัวใจ ด้วยการใช้ฝักถั่วลันเตาทั้งฝักที่ล้างน้ำสะอาดแล้ว นำไปคั้นเอาแต่น้ำให้ได้ประมาณครึ่งถึงหนึ่งแก้ว ใช้ดื่มวันละ 2 ครั้ง ช่วงเช้าและเย็น\n7.ช่วยรักษาโรคความดันโลหิต ด้วยการใช้ฝักถั่วลันเตาทั้งฝักที่ล้างน้ำสะอาดแล้ว นำไปคั้นเอาแต่น้ำให้ได้ประมาณครึ่งถึงหนึ่งแก้ว ใช้ดื่มวันละ 2 ครั้ง ช่วงเช้าและเย็น\n8.ช่วยแก้เป็นตะคริว อาการเหน็บชา\n9.ช่วยบำรุงเส้นเอ็น\n10.ช่วยเพิ่มน้ำนมของสตรี",
      "properties_eng":
          "1. The shoots of green peas are high in beta-carotene. which helps to nourish eyesight and skin\n2. Used to treat diabetes. Patients with diabetes should eat regularly by using fresh pods to wash thoroughly and bring to a boil until cooked. then taken orally on a regular basis\n3. Help reduce blood cholesterol levels.\n4. Seeds help nourish fat.\n5. Green peas are rich in B vitamins, vitamin B12 and Lecithin, which are essential for the functioning of the nervous system. thus helping to prevent forgetfulness\n6. Help cure heart disease. by using whole pea pods that have been washed with clean water Used to squeeze only about half to one glass of water, use to drink 2 times a day, morning and evening.\n7. Help cure blood pressure disease. by using whole pea pods that have been washed with clean water Used to squeeze only about half to one glass of water, use to drink 2 times a day, morning and evening.\n8. Helps to relieve cramps, beriberi symptoms\n9. Help nourish tendons.\n10. Help increase women's milk.",
      "url_img": "assets/images/Sweet peas.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%96%e0%b8%b1%e0%b9%88%e0%b8%a7%e0%b8%a5%e0%b8%b1%e0%b8%99%e0%b9%80%e0%b8%95%e0%b8%b2\/"
    },
    {
      "id": 9,
      "name_th": "หอมแดง",
      "name_eng": "Shallots",
      "category": "Fruit",
      "properties_th":
          "1.ช่วยทำให้ร่างกายอบอุ่น \n2.หอมแดงช่วยทำให้เจริญอาหาร (ผล,ใบ) \n3.ร่างกายซูบผอม แก้ด้วยการใช้เมล็ดแห้ง 5-10 กรัมนำมาต้มน้ำดื่ม \n4.มีส่วนช่วยเสริมสร้างความจำ ทำให้ความจำดีขึ้น \n5.ช่วยบำรุงโลหิต \n6.ช่วยบำรุงหัวใจ \n7.ช่วยเจริญธาตุไฟ \n8.ช่วยต่อต้านอนุมูลอิสระ \n9.ช่วยเพิ่มการไหลเวียนของโลหิตให้ดีขึ้น \n10.ช่วยแก้อาการวิงเวียนศีรษะ หน้ามืด ตาลาย เป็นลม",
      "properties_eng":
          "1. Help warm the body.\n2. Shallots help make appetite (results, leaves)\n3. A skinny body Solve by using 5-10 grams of dried seeds to boil drinking water.\n4. Helps to strengthen memory. improve memory\n5. Help nourish blood.\n6. Help nourish the heart.\n7. Help prosper the fire element.\n8. Help against free radicals.\n9. Improves blood circulation.\n10. Helps to relieve dizziness, dizziness, dizziness, fainting.",
      "url_img": "assets/images/Shallots.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%ab%e0%b8%ad%e0%b8%a1%e0%b9%81%e0%b8%94%e0%b8%87\/"
    },
    {
      "id": 10,
      "name_th": "แตงโม",
      "name_eng": "Watermelon",
      "category": "Fruit",
      "properties_th":
          "1.ช่วยแก้เบาหวานและดีซ่าน ช่วยบำรุงสมอง (เมล็ด) \n2.ช่วยบำรุงร่างกาย (เมล็ด) \n3.ช่วยบำรุงปอด (เมล็ด) \n4.แตงโมมีสรรพคุณช่วยควบคุมความดันโลหิตและมีส่วนช่วยลดความดันโลหิตลงได้ (Citrulline) \n5.ช่วยรักษาโรคหลอดเลือดแดงแข็งตัวได้ \n6.ช่วยป้องกันและรักษาโรคเลือดออกตามไรฟัน \n7.ช่วยป้องกันหวัด \n8.ช่วยลดอาการไข้ แก้คอแห้ง (น้ำแตงโม) \n9.ใช้เป็นยาลดไข้ด้วยการใช้ใบมาชงดื่ม (ใบ)\n10.แก้อาการเมาเหล้",
      "properties_eng":
          "1. Helps to cure diabetes and jaundice. Nourishes the brain (seeds)\n2. Help nourish the body (seeds).\n3. Help nourish the lungs (seeds).\n4. Watermelon has properties that help control blood pressure and can help reduce blood pressure (Citrulline).\n5. It can help cure arteriosclerosis.\n6. Help prevent and cure scurvy.\n7. Help prevent cold.\n8. Help reduce fever, dry throat (watermelon juice)\n9. Used as a fever reducer by using the leaves to drink (leaves).\n10. cure drunkenness",
      "url_img": "assets/images/Watermelon.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b9%81%e0%b8%95%e0%b8%87%e0%b9%82%e0%b8%a1\/"
    },
    {
      "id": 11,
      "name_th": "ดอกแค",
      "name_eng": "Dok Khae",
      "category": "Flower",
      "properties_th":
          "1.ช่วยเสริมสร้างภูมิคุ้มกันให้กับร่างกาย ช่วยป้องกันและรักษาอาการหวัด\n2.ช่วยคุมธาตุในร่างกาย  \n3.ช่วยในเรื่องความจำ ป้องกันการเกิดเนื้องอก บรรเทาอาการไข้ ปวด โลหิตจาง ด้วยการใช้ฝักแคสด 20 กรัม นำมาเคี่ยวกับน้ำ 1 ลิตร ประมาณ 30 นาที กรองเอาฝักออก นำมาดื่มก่อนอาหาร 1 ชั่วโมง ในช่วงเช้า เย็น และก่อนนอน \n4.ช่วยบำรุงและรักษาสายตา เนื่องจากมีเบตาแคโรทีนที่ร่างกายสามารถเปลี่ยนเป็นวิตามินเอได้ \n5.ช่วยแก้โรคตาบอดตอนกลางคืน ด้วยการใช้ใบสด 20 กรัม เทน้ำเดือด 1 ลิตร ทิ้งไว้ 15 นาที แล้วกรองเอาใบแคออก นำมาดื่มแก้อาการ\n6.ช่วยบำรุงและเสริมสร้างกระดูกและฟัน เนื่องจากอุดมไปด้วยแคลเซียมและฟอสฟอรัส \n7.ดอกแคมีสรรพคุณช่วยแก้ไข้ ลดอาการไข้ ถอนพิษไข้ในร่างกาย ช่วยแก้ไข้หัวลมหรือไข้เปลี่ยนอากาศ เปลี่ยนฤดู ด้วยการใช้ดอกหรือใบนำมาต้มกับน้ำรับประทาน หรือจะใช้ดอกที่โตเต็มที่นำมาล้างน้ำ แล้วต้มกับหมูทำหมูบะช่อ 1 ชาม แล้วรับประทานวันละ 1 มื้อ ติดต่อกัน 3-7 วัน อาการก็จะดีขึ้น  \n8.น้ำคั้นจากรากใช้ผสมกับน้ำผึ้ง ใช้ดื่มก่อนอาหาร 1 ชั่วโมง ในช่วงเช้า กลางวัน และก่อนนอน ใช้เป็นยาขับเสมหะ ลดอาการไอ แก้ร้อนใน แก้ไข้ลมหัวได้ \n9.ช่วยบรรเทาอาการของโรคลมบ้าหมู ด้วยการใช้ใบสด 20 กรัม เทน้ำเดือด 1 ลิตร ทิ้งไว้ 15 นาที แล้วกรองเอาใบแคออก นำมาดื่มก่อนอาหาร 1 ชั่วโมง ในช่วงเช้า เย็น และก่อนนอน \n10.ช่วยแก้อาการปวดและหนักศีรษะ ด้วยการใช้น้ำคั้นที่ได้จากดอกและใบแคนำมาสูดเข้าจมูกเพื่อช่วยบรรเทาอาการ ",
      "properties_eng":
          "1. Help strengthen the body's immunity. Help prevent and treat cold symptoms.\n2. Help control the elements in the body.\n3. help with memory prevent tumor formation Relieve fever, pain, anemia by using 20 grams of fresh pods, bring to simmer with 1 liter of water for about 30 minutes, filter out the pods. Take it to drink 1 hour before meals in the morning, evening and before bedtime.\n4. Help nourish and maintain eyesight. Because there is beta-carotene that the body can convert into vitamin A.\n5. Help cure night blindness. By using 20 grams of fresh leaves, pour 1 liter of boiling water, leave for 15 minutes, then strain the leaves. Brought to drink to relieve symptoms\n6. Help nourish and strengthen bones and teeth. Because it is rich in calcium and phosphorus.\n7. Came flowers have properties to help resolve fever, reduce fever, neutralize fever in the body. Helps to cure wind fever or fever, change the weather, change the season by using flowers or leaves to boil with drinking water. Or use the mature flowers to wash with water. Then boil it with pork, make 1 bowl of pork ribs and eat 1 meal a day for 3-7 days in a row, the symptoms will improve.\n8. Juice from the root used to mix with honey. Drink 1 hour before meals in the morning, noon and before bedtime.\n9. Help relieve symptoms of epilepsy. By using 20 grams of fresh leaves, pour 1 liter of boiling water, leave for 15 minutes, then strain the leaves. Take it to drink 1 hour before meals in the morning, evening and before bedtime.\n10. Helps to relieve pain and heavy head. by using the juice from the flowers and leaves of the cauliflower to inhale to help alleviate symptoms",
      "url_img": "assets/images/Dok Khae.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%94%e0%b8%ad%e0%b8%81%e0%b9%81%e0%b8%84\/"
    },
    {
      "id": 12,
      "name_th": "พญาสัตบรรณ",
      "name_eng": "Phaya Sattabun",
      "category": "Flower",
      "properties_th":
          "1.ช่วยแก้โลหิตพิการ\n2.ใช้เป็นยาขมช่วยให้เจริญอาหาร\n3.เปลือกต้นสัตบรรณมีสรรพคุณช่วยลดระดับน้ำตาลในเลือด รักษาโรคเบาหวาน \n4.น้ำยางจากต้นใช้หยอดหูแก้อาการปวดหูได้\n5.น้ำยางจากต้นใช้อุดฟันเพื่อแก้อาการปวดฟันได้ \n6.ใบอ่อนใช้ชงดื่ม ช่วยรักษาโรคเลือดออกตามไรฟันหรือโรคลักปิดลักเปิดได้\n7.เปลือกต้นใช้แก้หวัด แก้อาการไอ รักษาหลอดลมอักเสบ \n8.ช่วยแก้ไข้\n9.ดอกช่วยแก้ไข้เหนือ ไข้ตัวร้อน \n10.เปลือกต้นต้มน้ำดื่ม สรรพคุณช่วยรักษาโรคมาลาเรีย",
      "properties_eng":
          "1. Helps to cure blood disabilities\n2. Used as a bitter medicine to help appetite.\n3. The bark of the Sorban tree has properties that help reduce blood sugar levels. cure diabetes\n4. The latex from the tree can be used as ear drops to relieve ear pain.\n5. The latex from the tree can be used to fill teeth to relieve toothache.\n6. Young leaves are used to brew and drink. Helps treat scurvy or scurvy.\n7. The bark is used to cure colds, coughs, bronchitis treatment.\n8. Help solve fever.\n9. Flowers help cure fever, fever, fever.\n10.Boiled bark to drink water Efficacy helps to cure malaria",
      "url_img": "assets/images/Phaya Sattabun.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%9e%e0%b8%8d%e0%b8%b2%e0%b8%aa%e0%b8%b1%e0%b8%95%e0%b8%9a%e0%b8%a3%e0%b8%a3%e0%b8%93\/"
    },
    {
      "id": 13,
      "name_th": "ผักขม",
      "name_eng": "Amaranth",
      "category": "Leaves",
      "properties_th":
          "1.ช่วยบำรุงกำลังทำให้มีสุขภาพแข็งแรง \n2.ผักโขมมีสารต่อต้านอนุมูลอิสระหลายชนิด จึงมีส่วนช่วยในการชะลอวัยและความเสื่อมของเซลล์ต่าง ๆ ในร่างกาย \n3.ช่วยส่งเสริมการสร้างคอลลาเจน เพิ่มความยืดหยุ่นให้กับผิวหนัง จึงช่วยชะลอการเกิดริ้วรอยได้ \n4.ช่วยบำรุงและรักษาสุขภาพสายตา ป้องกันความเสื่อมของดวงตา \n5.มีส่วนช่วยบำรุงกระดูกและฟันให้แข็งแรง ลดความเสี่ยงของการเกิดโรคกระดูกพรุน \n6.ช่วยชะลอความเสื่อมของสมอง ชะลอปัญหาความจำเสื่อม \n7.ช่วยบำรุงโลหิตในร่างกาย \n8.ช่วยลดความเสี่ยงของการเกิดโรคหัวใจ \n9.ช่วยรักษาจังหวะการเต้นของหัวใจให้คงที่ \n10.ช่วยให้เจริญอาหาร แก้อาการเบื่ออาหาร",
      "properties_eng":
          "1. Help nourish energy, make you healthy.\n2. Spinach contains many types of antioxidants. thus helping to slow down aging and deterioration of various cells in the body\n3. Help promote the creation of collagen. Increase skin elasticity It can help slow down the aging process.\n4. Help nourish and maintain eye health. Prevent eye deterioration\n5. Helps to nourish bones and teeth to be strong. Reduce the risk of developing osteoporosis.\n6. Help slow down the deterioration of the brain. Slow down the problem of memory loss.\n7. Help nourish blood in the body.\n8. Help reduce the risk of heart disease.\n9. Help maintain a stable heartbeat.\n10. Helps appetite. cure anorexia",
      "url_img": "assets/images/Amaranth.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%9c%e0%b8%b1%e0%b8%81%e0%b9%82%e0%b8%82%e0%b8%a1\/"
    },
    {
      "id": 14,
      "name_th": "น้ำเต้า",
      "name_eng": "Bottle gourd",
      "category": "Fruit",
      "properties_th":
          "1.รากช่วยทำให้เจริญอาหาร แต่ในประเทศจีนจะใช้เมล็ดนำไปต้มกับเกลือรับประทานเป็นยาเจริญอาหาร\n2.น้ำเต้าเป็นยาเย็นและชื้น มีประโยชน์สำหรับผู้ป่วยที่เป็นโรคหัวใจและผู้ชราภาพ\n3.น้ำเต้าช่วยป้องกันการเกิดโรคมะเร็ง โดยเฉพาะอย่างยิ่งโรคมะเร็งปอด\n4.ใบมี ผลอ่อน และเนื้อในผล ช่วยลดระดับน้ำตาลในเลือด\n5.น้ำมันจากเมล็ดใช้ทาศีรษะจะช่วยแก้อาการทางประสาทบางชนิดได้\n6.เมล็ดช่วยแก้อาการปวดศีรษะ\n7.ใบมีรสเย็น ช่วยดับพิษ เป็นยาแก้ไข้ตัวร้อน\n8.ช่วยแก้อาการไอ\n9.ช่วยแก้อาการร้อนใน กระหายน้ำ\n10.เปลือกผลใช้ผสมหัวทารกเพื่อใช้ลดอาการไข้",
      "properties_eng":
          "1. Roots help make appetite But in China, the seeds are boiled with salt and eaten as an appetite suppressant.\n2. Gourds are cold and moist medicine. Useful for heart patients and the elderly.\n3. Gourds help prevent cancer. especially lung cancer\n4.Leaves, soft fruits and flesh in the fruit help reduce blood sugar levels.\n5.Seed oil applied to the head can help cure some types of nervous conditions.\n6. Seeds help relieve headaches.\n7. The leaves have a cool taste, helping to extinguish toxicity as a fever remedy.\n8. Helps to cure cough.\n9. Helps to relieve heat in thirsty\n10. The fruit peel is used to mix the baby's head to reduce fever.",
      "url_img": "assets/images/Bottle gourd.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%99%e0%b9%89%e0%b8%b3%e0%b9%80%e0%b8%95%e0%b9%89%e0%b8%b2\/"
    },
    {
      "id": 15,
      "name_th": "กะหล่ำปลี",
      "name_eng": "Cabbage",
      "category": "Leaves",
      "properties_th":
          "1.กะหล่ำปลีมีกรดทาร์ทาริก (Tartaric acid) ที่ช่วยยับยั้งและขัดขวางไม่ให้น้ำตาลและแป้งกลายเป็นไขมัน จึงมีส่วนในการช่วยลดน้ำหนักและคอเลสเตอรอลได้\n2.ช่วยบำรุงกระดูกและฟัน เพราะกะหล่ำปลีดิบอุดมไปด้วยแคลเซียมและฟอสฟอรัส ซึ่งเป็นผลดีต่อการเสริมสร้างและบำรุงกระดูก\n3.ช่วยเสริมสร้างภูมิคุ้มกันโรคให้แข็งแรง ป้องกันหวัด เพราะกะหล่ำปลีดิบมีวิตามินสูง\n4.ช่วยบำรุงผิวพรรณทำให้ผิวพรรณเปล่งปลั่งมีน้ำมีนวล และยังช่วยคงความอ่อนเยาว์ได้อีกด้วย\n5.กะหล่ำปลีมีสารเอสเมธิลเมโธโอนินที่สามารถช่วยรักษาโรคกระเพาะอาหารได้\n6.ช่วยต่อต้านมะเร็ง ยับยั้งการเจริญเติบโตของเซลล์มะเร็งลำไส้ ช่วยลดความเสี่ยงของการเกิดโรคมะเร็งลำไส้ได้ โดยการบริโภคกะหล่ำปลีมากกว่า 1 ครั้งต่อสัปดาห์ จะช่วยลดโอกาสของการเป็นมะเร็งลำไส้ในผู้ชายได้ถึง 66%\n7.กะหล่ำปลีช่วยต่อต้านมะเร็งในตับและมีส่วนช่วยป้องกันมะเร็งต่อมลูกหมากได้อีกด้วย\n8.ช่วยในการย่อยอาหารและล้างสารพิษทำความสะอาดลำไส้ เพราะกะหล่ำปลีดิบมีใยอาหารที่มีปริมาณพอเหมาะ จึงช่วยในการย่อยและกระตุ้นการทำงานของลำไส้ใหญ่ ช่วยทำให้ระบบขับถ่ายทำงานได้อย่างมีประสิทธิภาพ\n9.ช่วยรักษาแผลในกระเพาะอาหาร บรรเทาอาการอักเสบของแผลในลำไส้ และยังช่วยบำรุงลำไส้\n10.กะหล่ำปลี สรรพคุณช่วยแก้อาการจุกเสียดแน่นท้อง",
      "properties_eng":
          "1. Cabbage contains tartaric acid (Tartaric acid) that inhibits and prevents sugar and starch from turning into fat. thus helping to reduce weight and cholesterol\n2. Helps nourish bones and teeth. Because raw cabbage is rich in calcium and phosphorus. which is good for strengthening and nourishing bones\n3. Help strengthen immunity, prevent colds because raw cabbage is high in vitamins.\n4. Help nourish the skin, make the skin radiant, hydrated. and also helps maintain youthfulness as well\n5. Cabbage contains methyl methionin that can help treat stomach disease.\n6. Help against cancer. inhibit the growth of colon cancer cells It can help reduce the risk of colon cancer. by consuming cabbage more than 1 time per week It reduces the chances of colon cancer in men by up to 66%.\n7. Cabbage helps fight liver cancer and helps prevent prostate cancer as well.\n8. Helps in digestion and detoxification, cleansing the intestines. Because raw cabbage contains a good amount of dietary fiber. It helps in digestion and stimulates the functioning of the colon. Helps to make the excretory system work more efficiently\n9. Help heal stomach ulcers. Relieves inflammation of intestinal ulcers. and also helps nourish the intestines\n10. Cabbage, properties that help relieve heartburn",
      "url_img": "assets/images/Cabbage.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%81%e0%b8%b0%e0%b8%ab%e0%b8%a5%e0%b9%88%e0%b8%b3%e0%b8%9b%e0%b8%a5%e0%b8%b5\/"
    },
    {
      "id": 16,
      "name_th": "ขึ้นฉ่าย",
      "name_eng": "Celery",
      "category": "Leaves",
      "properties_th":
          "1.ช่วยทำให้เจริญอาหาร กระตุ้นให้เกิดความอยากอาหาร \n2.ขึ้นฉ่ายเป็นผักที่มีโพแทสเซียมสูง ซึ่งช่วยในการขยายตัวของหลอดเลือด ป้องกันโรคหัวใจขาดเลือด \n3.ขึ้นฉ่ายมีโซเดียมอินทรีย์ที่ช่วยในการปรับสมดุลของกรดและด่างในเลือด 4.ขึ้นฉ่ายเป็นหนึ่งในผักที่มีสารโพลีฟีนอล ซึ่งเป็นตัวช่วยป้องกัน DNA ถูกทำลาย \n5.ช่วยลดอาการอักเสบ และป้องกันมะเร็งด้วยการไปยับยั้งการกลายพันธุ์และสารก่อมะเร็งในร่างกาย \n6.น้ำคั้นจากขึ้นฉ่ายมีสรรพคุณใช้เป็นยากล่อมประสาท ช่วยในการนอนหลับ ทำให้รู้สึกสบายขึ้น \n7.ช่วยลดปริมาณของคอเลสเตอรอล ระดับน้ำตาล ไตรกลีเซอไรด์ และไขมันในเส้นเลือด\n8.ช่วยบำรุงหัวใจและรักษาโรคหัวใจ \n9.ช่วยในการทำงานของระบบหมุนเวียนต่าง ๆ ในร่างกาย \n10.ช่วยลดอาการของโรคหอบหืด ขึ้นฉ่ายกับการล้างพิษในร่างกาย ขึ้นฉ่ายเป็นสุดยอดอาหารหรือผักที่ช่วยทำความสะอาดเลือด ช่วยทำให้ร่างกายสะอาด",
      "properties_eng":
          "1. Helps to make appetite. stimulate appetite\n2. Celery is a vegetable that is high in potassium. which helps in the expansion of blood vessels prevent ischemic heart disease\n3. Celery contains organic sodium that helps to balance acid and alkali in the blood. 4. Celery is one of the vegetables that contain polyphenols. which helps prevent DNA damage\n5. Help reduce inflammation. and prevent cancer by inhibiting mutations and carcinogens in the body\n6. Celery juice has properties used as an antidepressant. help to sleep make you feel more comfortable\n7. Help reduce the amount of cholesterol, sugar levels, triglycerides. and fat in blood vessels\n8. Help nourish the heart and cure heart disease.\n9. Helps in the work of various circulatory systems in the body.\n10. Help reduce the symptoms of asthma. Celery and detoxification in the body Celery is an excellent food or vegetable that helps clean the blood. Help clean the body.",
      "url_img": "assets/images/Celery.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%82%e0%b8%b6%e0%b9%89%e0%b8%99%e0%b8%89%e0%b9%88%e0%b8%b2%e0%b8%a2\/"
    },
    {
      "id": 17,
      "name_th": "บัวบก",
      "name_eng": "Gotu Kola",
      "category": "Leaves",
      "properties_th":
          "1.บัวบกเป็นพืชที่มีแคลเซียมในระดับปานกลางถึงสูง แต่มีระดับสารออกซาเลตที่เป็นอันตรายต่อร่างกายในปริมาณต่ำ \n2.ใบบัวบกช่วยคืนความอ่อนเยาว์ ย้อนอายุและวัย ใช้เป็นยาอายุวัฒนะ\n3.ช่วยเสริมสร้างและกระตุ้นการสร้างคอลลาเจนและอีลาสติน \n4.มีสารต่อต้านอนุมูลอิสระ ช่วยต่อต้านการเสื่อมของเซลล์ต่าง ๆในร่างกาย 5.ประโยชน์ของใบบัวบก ช่วยบำรุงและรักษาสายตา ฟื้นฟูรอบดวงตา เพราะบัวบกมีวิตามินเอสูง \n6.ช่วยรักษาอาการตาอักเสบบวมแดง ด้วยการใช้ใบบัวบกล้างน้ำสะอาด คั้นเอาแต่น้ำนำมาหยดที่ตา 3-4 ครั้งต่อวัน \n7.ช่วยบำรุงประสาทและสมองเหมือนใบแปะก๊วย \n8.ช่วยทำให้ความจำดีขึ้นและทำให้มีปฏิภาณไหวพริบเพิ่มมากขึ้น ช่วยเพิ่มความจำในผู้สูงอายุ\n9.ช่วยแก้อาการวิงเวียนศีรษะ \n10.ช่วยผ่อนคลายความเครียด",
      "properties_eng":
          "1. Centella asiatica is a medium to high calcium plant. But there are low levels of oxalates that are harmful to the body.\n2. Centella asiatica helps restore youthfulness. age and age Used as an elixir\n3. Help strengthen and stimulate the creation of collagen and elastin.\n4. Contains antioxidants Helps against deterioration of various cells in the body. 5. Benefits of Centella asiatica leaves. Help nourish and maintain eyesight. rejuvenation around the eyes Because centella asiatica has high vitamin A.\n6. Helps treat eye inflammation, swelling, redness. by using Centella asiatica leaves to wash with clean water Squeeze only juice and drip it into your eyes 3-4 times a day.\n7. Helps nourish the nerves and brain like ginkgo leaves.\n8. Helps make memory better and make more witty. Improves memory in the elderly\n9. Helps to cure dizziness.\n10. Help relax stress.",
      "url_img": "assets/images/Gotu Kola.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b9%83%e0%b8%9a%e0%b8%9a%e0%b8%b1%e0%b8%a7%e0%b8%9a%e0%b8%81\/"
    },
    {
      "id": 18,
      "name_th": "เพชรสังฆาต",
      "name_eng": "Phechrsangkhat",
      "category": "Stalk",
      "properties_th":
          "1.เพชรสังฆาตใช้ปรุงเป็นยาธาตุ ช่วยให้เจริญอาหาร \n2.น้ำจากต้นเพชรสังฆาตใช้หยอดหู แก้น้ำหนวกไหล\n3.น้ำจากต้นเพชรสังฆาตใช้หยอดจมูก แก้เลือดเสียในสตรี ประจำเดือนไม่ปกติ \n4.ช่วยขับน้ำเหลืองเสีย \n5.ใช้เถาเพชรสังฆาตคั้นเอาน้ำมาดื่มแก้โรคลักปิดลักเปิดหรือโรคเลือดออกตามไรฟันได้ \n6.ช่วยรักษาโรคลำไส้ที่เกี่ยวกับอาหารไม่ย่อย  \n7.เพชรสังฆาตมีสรรพคุณช่วยขับลมในลำไส้ \n8.แก้อาการประจำเดือนมาไม่ปกติ \n9.แก้กระดูกแตก หัก ซ้น \n10.ใช้เป็นยาพอกเมื่อกระดูกหัก \n11.ใช้เป็นยารักษาริดสีดวง",
      "properties_eng":
          "1. Cissus quadrangularis is used to concoct an elemental medicine. help appetite\n2. Water from the stinging diamond plant is used as ear drops. solve otitis\n3. Water from the Sangkhus Phetchabun plant is used to drop the nose. Solve blood loss in women irregular menstruation\n4. Help drive lymphatic waste.\n5. Use Cissus quadrangularis vine to drink water to cure scurvy or scurvy.\n6. Help cure intestinal disease related to indigestion.\n7. Cissus quadrangularis has properties that help drive wind in the intestines.\n8. Solve menstrual symptoms that are not normal.\n9. Fix broken bones, overlap\n10. Used as a poultice when broken bones\n11. Used as a treatment for hemorrhoids.",
      "url_img": "assets/images/Phechrsangkhat.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b9%80%e0%b8%9e%e0%b8%8a%e0%b8%a3%e0%b8%aa%e0%b8%b1%e0%b8%87%e0%b8%86%e0%b8%b2%e0%b8%95\/"
    },
    {
      "id": 19,
      "name_th": "ตำลึง",
      "name_eng": "Ivy gourd",
      "category": "Leaves",
      "properties_th":
          "1.ช่วยต่อต้านอนุมูลอิสระ ป้องกันความเสื่อมความเซลล์ต่าง ๆ ในร่างกาย \n2.ช่วยบำรุงผิวพรรณ \n3.ช่วยซ่อมแซมและสร้างเนื้อเยื่อในร่างกาย \n4.ช่วยป้องกันการเกิดโรคมะเร็ง \n5.ช่วยลดความเสี่ยงของการเกิดโรคมะเร็งในกระเพาะอาหาร \n6.ช่วยรักษาโรคเบาหวาน ด้วยการใช้เถาแก่ 1 กำมือ นำมาต้มกับน้ำหรือจะใช้น้ำคั้นจากผลดิบ นำมาดื่มวันละ 2 รอบ เช้า,เย็น จะช่วยลดระดับน้ำตาลในเลือด เพิ่มระดับอินซูลิน \n7.ช่วยป้องกันการเกิดโรคโลหิตจาง\n8.ช่วยป้องกันโรคหัวใจขาดเลือด จึงช่วยป้องกันการเกิดอัมพาตด้วย \n9.ช่วยบำรุงกระดูกและฟันให้แข็งแรง\n10.ช่วยบำรุงและรักษาสายตา",
      "properties_eng":
          "1. Helps against free radicals Prevent the deterioration of various cells in the body.\n2. Help nourish skin.\n3. Help repair and build tissues in the body.\n4. Help prevent cancer.\n5. Help reduce the risk of stomach cancer.\n6. Help cure diabetes. By using 1 handful of old vines, bring to boil with water or use juice from raw fruits. Brought to drink 2 times a day, morning and evening, will help reduce blood sugar levels. increase insulin levels\n7. Help prevent anemia.\n8. Help prevent ischemic heart disease. thus helping to prevent paralysis as well\n9. Help nourish bones and teeth to be strong.\n10. Help nourish and maintain eyesight.",
      "url_img": "assets/images/Ivy gourd.jpg",
      "url":
          "https:\/\/medthai.com\/%E0%B8%95%E0%B8%B3%E0%B8%A5%E0%B8%B6%E0%B8%87\/"
    },
    {
      "id": 20,
      "name_th": "บีทรูท",
      "name_eng": "Beetroot",
      "category": "Roots",
      "properties_th":
          "1.บีทรูทมีสารต่อต้านอนุมูลอิสระ จึงช่วยป้องกันความเสื่อมของเซลล์ต่าง ๆ ในร่างกาย \n2.การดื่มน้ำบีทรูทเป็นประจำจะช่วยเสริมสร้างพละกำลังและความแข็งแรง ลดอาการเหนื่อยล้าจากการออกกำลัง ทำให้อึดทนทานมากขึ้นถึง 16% ถ้าหลังจากดื่มน้ำบีทรูทแล้วขับถ่ายออกมามีสีแดงปนเปื้อนมาด้วยก็ไม่ต้องตกใจ มันไม่ใช่เลือดแต่เป็นเพราะร่างกายขับสารสีแดงออกมาเท่านั้นเอง \n3.สารสกัดจากบีทรูทที่อุดมไปด้วยไนเตรตเป็นสารที่มีประโยชน์ต่อผู้ป่วยที่มีระดับไขมันในเลือดสูง ช่วยลดการสะสมไขมันและลดการอุดตันในหลอดเลือด 4.ช่วยทำให้เจริญอาหารมากยิ่งขึ้น \n5.ช่วยเพิ่มการไหลเวียนของโลหิตให้ไปเลี้ยงส่วนต่าง ๆ ของร่างกายได้ดีขึ้น \n6.ช่วยล้างสารพิษในร่างกาย \n7.ช่วยยับยั้งสารก่อมะเร็งและลดการเจริญเติบโตของเนื้องอก 8.ช่วยลดจำนวนสารก่อมะเร็งในร่างกาย \n9.ช่วยบำรุงสุขภาพของหัวใจและหลอดเลือดให้แข็งแรง \n10.ช่วยลดความเสี่ยงของการเกิดโรคหัวใจ",
      "properties_eng":
          "1. Beetroot contains antioxidants. thus helping to prevent the degeneration of various cells in the body\n2. Drinking beetroot juice regularly will help build strength and strength. Reduce fatigue from exercise Makes it endure up to 16% more. It's not blood, it's just because the body excretes the red substance.\n3. Beetroot extract, rich in nitrates, is a beneficial substance for patients with high blood lipid levels. Help reduce fat accumulation and reduce clogging in blood vessels. 4. Helps to increase appetite.\n5. Improves blood circulation to feed different parts of the body better.\n6. Help detoxify the body.\n7. Help inhibit carcinogens and reduce tumor growth. 8. Help reduce the number of carcinogenic substances in the body.\n9. Help nourish the health of the heart and blood vessels.\n10. Help reduce the risk of heart disease.",
      "url_img": "assets/images/Beetroot.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%9a%e0%b8%b5%e0%b8%97%e0%b8%a3%e0%b8%b9%e0%b8%97\/"
    },
    {
      "id": 21,
      "name_th": "แตงกวา",
      "name_eng": "Cucumber",
      "category": "Fruit",
      "properties_th":
          "1.แตงกวามีสรรพคุณช่วยแก้กระหาย ลดความร้อนในร่างกาย ทำให้ร่างกายสดชื่น และช่วยเพิ่มความชุ่มชื้น \n2.ช่วยกำจัดของเสียที่ตกค้างในร่างกาย \n3.แตงกวามีสารฟีนอลที่ทำหน้าที่ต่อต้านอนุมูลอิสระต่าง ๆ \n4.ผลและเมล็ดอ่อนมีฤทธิ์ช่วยต่อต้านมะเร็ง \n5.ช่วยลดความดันโลหิต\n6.ช่วยรักษาสมดุลต่าง ๆ ในร่างกาย รักษาระดับน้ำตาลในเลือด ระดับภูมิคุ้มกันให้อยู่ในสุขภาพดี \n7.ช่วยควบคุมระดับความดันเลือดและความสมดุลของสารอาหารในร่างกาย \n8.ช่วยเสริมสร้างการทำงานของระบบประสาท ระบบกล้ามเนื้อ ระบบการหมุนเวียนเลือด\n9.ช่วยเสริมสร้างการทำความของระบบประสาท เพิ่มความจำ \n10.ช่วยแก้อาการนอนไม่หลับ ",
      "properties_eng":
          "1. Cucumber has properties to help relieve thirst. reduce body heat refreshing the body and helps increase moisture\n2. Help eliminate residual waste in the body.\n3. Cucumbers contain phenols that act against free radicals.\n4. Fruits and young seeds have anti-cancer effects.\n5. Help reduce blood pressure.\n6. Help maintain various balances in the body, maintain blood sugar levels. Immune levels to stay healthy\n7. Helps control blood pressure and nutrient balance in the body.\n8. Help strengthen the functioning of the nervous system. musculoskeletal system blood circulation system\n9. Help strengthen the functioning of the nervous system, increase memory.\n10. Helps to cure insomnia.",
      "url_img": "assets/images/Cucumber.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b9%81%e0%b8%95%e0%b8%87%e0%b8%81%e0%b8%a7%e0%b8%b2\/"
    },
    {
      "id": 22,
      "name_th": "ผักชีฝรั่ง",
      "name_eng": "Culantro",
      "category": "Leaves",
      "properties_th":
          "1.ผักชีฝรั่งมีสารต่อต้านอนุมูลอิสระสูง ซึ่งช่วยชะลอการเสื่อมของเซลล์ต่าง ๆ ในร่างกาย\n2.ผักชีฝรั่งมีประโยชน์ช่วยบำรุงกระดูกและฟันให้แข็งแรง\n3.ช่วยยับยั้งและชะลอการขยายตัวของเซลล์มะเร็ง ช่วยป้องกันการเกิดโรคมะเร็ง\n4.ช่วยลดระดับความดันโลหิต\n5.ช่วยทำให้ต่อมไทรอยด์ทำงานได้อย่างเป็นปกติ (ลำต้น) ช่วยบำรุงผิวพรรณ เส้นผม และเล็บให้แข็งแรง\n6.ช่วยบำรุงผิวพรรณ เส้นผม และเล็บให้แข็งแรง\n7.ช่วยรักษาสมดุลในร่างกายได้เป็นอย่างดี (ใบทำเป็นชาชงดื่มวันละ 3 ถ้วย)\n8.ช่วยบรรเทาอาการปวดศีรษะ\n9.ช่วยระบายท้อง ด้วยการใช้น้ำคั้นหรือน้ำต้มจากใบนำมาดื่ม\n10.ช่วยแก้อาการปวดเมื่อยตามร่างกาย ด้วยการใช้ลำต้นของผักชีฝรั่งนำมาตำผสมกับน้ำมันงาแล้วนำไปหมกไฟให้สุก จึงค่อยนำมาประคบแก้อาการปวดเมื่อย",
      "properties_eng":
          "1. Parsley is high in anti-oxidants. which helps slow down the deterioration of various cells in the body\n2. Parsley is useful to help maintain strong bones and teeth.\n3. Help inhibit and slow down the growth of cancer cells. Help prevent cancer.\n4. Help reduce blood pressure levels.\n5. Helps make the thyroid gland work normally (trunks). Helps nourish skin, hair and nails to be strong.\n6. Help nourish skin, hair and nails to be healthy.\n7. Helps maintain balance in the body very well. (The leaves are made into tea. Drink 3 cups a day.)\n8. Help relieve headache.\n9. Help drain the stomach. By using juice or boiled water from the leaves to drink.\n10. Helps to relieve body aches. By using the stems of parsley to pound, mix with sesame oil and bring to cook until cooked. Therefore gradually bring to compress to relieve pain.",
      "url_img": "assets/images/Culantro.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%9c%e0%b8%b1%e0%b8%81%e0%b8%8a%e0%b8%b5%e0%b8%9d%e0%b8%a3%e0%b8%b1%e0%b9%88%e0%b8%87\/"
    },
    {
      "id": 23,
      "name_th": "เสลดพังพอน",
      "name_eng": "Esldpagpon",
      "category": "Leaves",
      "properties_th":
          "1.ใช้เป็นยารักษาโรคบิด\n2.รากใช้ปรุงเป็นยาขับปัสสาวะ ขับประจำเดือน\n3.ใช้เป็นยาแก้ประจำเดือนมาไม่ปกติ \n4.ช่วยแก้อักเสบแบบดีซ่าน\n5.ใช้เป็นยาแก้แผลอักเสบมีไข้ ไข่ดันบวม ด้วยการใช้ใบสดประมาณ 3-4 ใบ นำมาตำกับข้าวสาร 3-4 เม็ด ผสมกับน้ำพอเปียก ใช้พอกประมาณ 2-3 รอบ จะช่วยให้อาการดีขึ้น\n6.ลำต้นนำมาฝนแล้วใช้ทาแผลสดจะช่วยทำให้แผลหายเร็ว\nใช้รักษาแผลจากสุนัขกัดมีเลือดไหล ด้วยการใช้ใบสดประมาณ 5 ใบ นำมาตำพอกบริเวณแผลสัก 10 นาที\n7.ใช้รักษาแผลไฟไหม้น้ำร้อนลวก ด้วยการใช้ใบสดนำมาตำเคี่ยวกับน้ำมะพร้าวหรือน้ำมันงา เอากากพอกแผล แผลจะแห้ง หรือจะใช้ใบสดนำมาตำให้ละเอียดผสมกับเหล้า ใช้เป็นยาพอกบริเวณที่ถูกไฟไหม้หรือน้ำร้อนลวก จะมีสรรพคุณช่วยดับพิษร้อนได้ดี\n8.ช่วยรักษาแผลเปื่อยเนื่องจากถูกแมงกะพรุนไฟ แผลสุนัขกัด และแผลที่เกิดจากการถูกกรดได้อีกด้วย เพียงแค่นำใบไปหุงกับน้ำมันแล้วนำมาทาบริเวณที่เป็น\n9.ใช้รักษาแผลน้ำเหลืองเสีย ด้วยการใช้ใบประมาณ 3-4 ใบ กับข้าวสาร 5-6 เม็ด เติมน้ำลงไปให้พอเปียก แล้วนำมาพอก จะรู้สึกเย็น ๆ ซึ่งยาจะช่วยดูดน้ำเหลืองได้ดี ทำให้แผลแห้งไว โดยให้เปลี่ยนยาวันละ 2 ครั้ง พอกไปสักพักหนึ่งแล้วให้เอาน้ำมาหยอดกันยาแห้งด้วย\n10.ใช้แก้โรคผิวหนังผื่นคัน ด้วยการใช้ใบสดตำผสมกับเหล้าใช้ทา หรือใช้เหล้าสกัดใบเสลดพังพอน จะได้น้ำยาสีเขียวนำมาทาแก้ผื่นคัน ",
      "properties_eng":
          "1. Used as a treatment for dysentery.\n2. The root is used to cook as a diuretic. monthly drive\n3. Used as a remedy for irregular menstruation\n4. Help cure jaundice inflammation.\n5. Used as a cure for inflammation, fever, swollen eggs by using about 3-4 fresh leaves, pounding 3-4 tablets of rice, mixing with water, when wet, masking about 2-3 rounds will help improve symptoms\n6. Stems bring rain and apply fresh wounds to help make the wound heal faster.\nUsed to treat bleeding wounds from dog bites. By using about 5 fresh leaves, bring to pound and mask the wound for 10 minutes.\n7. Use to treat burns, scalds. By using fresh leaves to pound, stew with coconut water or sesame oil, mask the residue on the wound, the wound will dry, or use fresh leaves to pound thoroughly mixed with liquor. Use as a poultice on burned or scalded areas. There will be properties to help extinguish heat well.\n8. Helps heal ulcers due to jellyfish, dog bites and acid wounds as well. Just bring the leaves to cook with oil and then apply to the area that is\n9. Used to treat lymphatic wounds. By using about 3-4 leaves with 5-6 grains of rice, add water to it until it's wet and then mask it. You will feel cool, which the drug will help absorb the lymph well make the wound dry quickly by changing the drug 2 times a day, masking for a while, then pouring water to prevent the drug from drying out\n10. Used to cure skin disease, rash, itchy. By using fresh leaves mixed with liquor to apply or use liquor to extract Esldpagpon leaves will get a green liquid to apply to cure rashes",
      "url_img": "assets/images/Esldpagpon.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b9%80%e0%b8%aa%e0%b8%a5%e0%b8%94%e0%b8%9e%e0%b8%b1%e0%b8%87%e0%b8%9e%e0%b8%ad%e0%b8%99%e0%b8%95%e0%b8%b1%e0%b8%a7%e0%b9%80%e0%b8%a1%e0%b8%b5%e0%b8%a2\/"
    },
    {
      "id": 24,
      "name_th": "ขิง",
      "name_eng": "Ginger",
      "category": "Roots",
      "properties_th":
          "1.ช่วยลดผลข้างเคียงจากสารเคมีที่ใช้ในการรักษามะเร็ง ดังนั้นควรรับประทานขิงควบคู่ไปกับการรักษามะเร็งจะเป็นผลดี \n2.ขิงมีฤทธิ์อุ่น ช่วยให้ร่างกายอบอุ่น และช่วยในการขับเหงื่อ \n3.ช่วยแก้อาการร้อนใน ด้วยการใช้ลำต้นสด ๆ นำมาทุบให้แหลกประมาณ 1 กำมือ แล้วต้มกับน้ำดื่ม \n4.ช่วยลดความอ้วน ลดระดับไขมัน คอเลสเตอรอล ด้วยการดูดซึมคอเลสเตอรอลจากลำไส้ แล้วปล่อยให้ร่างกายกำจัดออกทางอุจจาระ \n5.ช่วยรักษาอาการปวดศีรษะและไมเกรน ด้วยการรับประทานน้ำขิงบ่อย ๆ ช่วยลดความอยากของผู้ติดยาเสพติดลงได้ \n6.ช่วยรักษาโรคความดันโลหิต ด้วยการนำขิงสดมาฝานต้มกับน้ำดื่ม \n7.ช่วยบำรุงหัวใจของคุณให้แข็งแรง \n8.ช่วยบรรเทาอาการของโรคประสาท \n9.ช่วยฟื้นฟูร่างการสำหรับมารดาหลังคลอดบุตร \n10.ใช้บำรุงน้ำนมของมารดา",
      "properties_eng":
          "1. Help reduce side effects from chemicals used in cancer treatment. Therefore, eating ginger along with cancer treatment will be effective.\n2. Ginger has a warm effect. to keep the body warm and help in sweating\n3. Helps to relieve heat in By using fresh stems to be crushed, about 1 handful, then boiled with drinking water.\n4. Help reduce obesity, reduce fat, cholesterol levels by absorbing cholesterol from the intestines. Then let the body get rid of it through the stool.\n5. Helps treat headaches and migraines. By regularly consuming ginger water, it can help reduce the cravings of drug addicts.\n6. Help cure blood pressure disease. by bringing fresh ginger slices to boil with drinking water\n7. Help nourish your heart to be healthy.\n8. Help relieve the symptoms of neurosis.\n9. Help restore the body for mothers after giving birth.\n10. Use to nourish mother's milk.",
      "url_img": "assets/images/Ginger.jpg",
      "url": "https:\/\/medthai.com\/%e0%b8%82%e0%b8%b4%e0%b8%87\/"
    },
    {
      "id": 25,
      "name_th": "โสม",
      "name_eng": "Ginseng",
      "category": "Roots",
      "properties_th":
          "1.รากโสมเกาหลี มีรสหวานชุ่ม ขมเล็กน้อย เป็นยาสุขุม ออกฤทธิ์ต่อปอด ม้าม และกระเพาะอาหาร ใช้เป็นยาบำรุงกำลัง บำรุงอวัยวะภายในร่างกาย ทำให้ร่างกายชุ่มชื่น ช่วยแก้อาการอ่อนเพลีย\n2.ช่วยปรับสมดุลของร่างกาย ปรับการทำงานของต่อมไร้ท่อต่างๆ\n3.ช่วยแก้อาการหน้ามืดเป็นลม\n4.ช่วยแก้อาการเหงื่อออกไม่รู้ตัว กระหายน้ำ\n5.ช่วยแก้อาการเบื่ออาหาร\n6.ช่วยแก้หัวใจเต้นผิดปกติ หรือหายใจผิดปกติ\n7.โสมมีสรรพคุณเป็นยาช่วยบำรุงหัวใจ โดยออกฤทธิ์คล้ายกับยา digoxin ช่วยป้องกันโรคหัวใจขาดเลือด ป้องกันภาวะเส้นเลือดอุดตัน\n8.ใช้รักษาและป้องกันโรคผนังเส้นเลือดแดงใหญ่หนาและแข็ง โดยโสมจะไปช่วยทำให้คอเลสเตอรอลที่เกาะอยู่ตามผนังหลอดเลือดลดน้อยลง\n9.โสมมีฤทธิ์ต้านการจับตัวกันของเกล็ดเลือด อันเป็นสาเหตุสำคัญของการอุดตันของหลอดเลือด\n10.โสมมีฤทธิ์สร้างเม็ดเลือดแดง ซึ่งสามารถนำมาใช้รักษาผู้ที่มีเลือดน้อยหรือผู้ที่โลหิตจางและความดันต่ำได้ และยังช่วยสร้างเม็ดเลือดแดงในกระดูกได้อีกด้วย",
      "properties_eng":
          "1. Korean ginseng root has a sweet, slightly bitter taste. It is a sober medicine that acts on the lungs, spleen and stomach. Used as a tonic nourishing the internal organs of the body moisturize the body Help relieve exhaustion.\n2. Help balance the body. Adjust the function of various endocrine glands\n3. Helps to cure dizziness and faint.\n4. Helps to relieve sweating without knowing, thirsty\n5. Helps to cure anorexia.\n6. Helps to cure abnormal heartbeats. or abnormal breathing\n7. Ginseng has properties as a medicine to nourish the heart. It acts similarly to the drug digoxin, helping to prevent ischemic heart disease. prevent arteriosclerosis\n8. Used to treat and prevent thick and hard arterial wall disease The ginseng will help reduce the cholesterol that is on the artery walls.\n9. Ginseng has anti-platelet effect. which is a major cause of clogging of blood vessels\n10. Ginseng has the effect of creating red blood cells. Which can be used to treat people with low blood or people with anemia and low blood pressure. and also helps to produce red blood cells in the bones as well",
      "url_img": "assets/images/Ginseng.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b9%82%e0%b8%aa%e0%b8%a1%e0%b9%80%e0%b8%81%e0%b8%b2%e0%b8%ab%e0%b8%a5%e0%b8%b5\/"
    },
    {
      "id": 26,
      "name_th": "ข่า",
      "name_eng": "Galangal",
      "category": "Roots",
      "properties_th":
          "1.ข่ามีสาร 1-acetoxychavicol acetate (ACA) ซึ่งมีฤทธิ์ยับยั้งการเกิดโรคมะเร็งจากการเหนี่ยวนำของสารก่อมะเร็ง จึงช่วยป้องกันการเกิดโรคมะเร็งไปด้วยในตัว \n2.มีฤทธิ์ช่วยยับยั้งการเจริญเติบโตของเซลล์มะเร็ (สารสกัดจากเหง้า) \n3.สารสกัดจากเหง้ามีฤทธิ์ช่วยช่วยลดระดับน้ำตาลในเลือด \n4.ช่วยรักษาโรคหลอดลมอักเสบ\n5.ช่วยขับเลือดลมให้เดินสะดวก ช่วยเพิ่มการไหลเวียนของเลือดและเพิ่มการเผาผลาญของร่างกายให้ดีขึ้น \n6.น้ำมันหอมระเหยจากข่ามีประโยชน์อย่างมากต่อระบบทางเดินหายใจ จึงมีส่วนช่วยแก้อาการหวัด ไอ และเจ็บคอได้เป็นอย่างดี \n7.ช่วยแก้ลมแน่นหน้าอก \n8.ช่วยแก้ไข้สันนิบาตหน้าเพลิง \n9.ข่าสรรพคุณทางยาช่วยแก้เสมหะ \n10.ช่วยแก้อาการคลื่นไส้อาเจียน เมารถเมาเรือ ด้วยการใช้เหง้าข่าแก่สด ยาวประมาณ 1 นิ้วฟุตนำมาตำจนละเอียดแล้วเติมน้ำปูนใส ใช้น้ำยาดื่มครั้งละครึ่งแก้ว หลังอาหาร วันละ 3 เวลา ",
      "properties_eng":
          "1. Galangal contains 1-acetoxychavicol acetate (ACA), which has the effect of inhibiting cancer from the induction of carcinogens. thus helping to prevent cancer in itself\n2. Has the effect of inhibiting the growth of cancer cells (rhizome extract)\n3. Extracts from rhizomes have the effect of helping reduce blood sugar levels.\n4. Helps treat bronchitis\n5. Help drive the wind blood to walk easily. Improves blood circulation and improves metabolism of the body.\n6. Galangal essential oil is very beneficial to the respiratory system. Therefore, it helps to cure cold, cough and sore throat as well.\n7. Help solve the wind, tightness in the chest.\n8. Help solve the league in front of fire.\n9. Galangal medicinal properties help solve phlegm\n10.Helps relieve nausea and vomiting, motion sickness, seasickness by using fresh galangal rhizomes, about 1 inch long, pounded until fine and then filled with lime water. Use the liquid to drink half a glass at a time after meals, 3 times a day.",
      "url_img": "assets/images/Galangal.jpg",
      "url": "https:\/\/medthai.com\/%e0%b8%82%e0%b9%88%e0%b8%b2\/"
    },
    {
      "id": 27,
      "name_th": "คะน้า",
      "name_eng": "Kai-Lan",
      "category": "Leaves",
      "properties_th":
          "1.มีสารต่อต้านอนุมูลอิสระ จึงช่วยชะลอความเสื่อมของเซลล์ต่าง ๆ ในร่างกายได้ \n2.ช่วยเสริมสร้างภูมิต้านทานในกับร่างกาย ทำให้มีสุขภาพแข็งแรง \n3.ช่วยบำรุงผิวพรรณและป้องกันการติดเชื้อต่าง ๆ \n4.ผักคะน้ามีวิตามินซี ซึ่งมีส่วนช่วยเสริมสร้างเนื้อเยื่อให้ชุ่มชื้นมากขึ้น (วิตามินซี) \n5.ช่วยบำรุงและรักษาสายตา (วิตามินเอ) \n6.คะน้ามีสารลูทีน (Lutein) ซึ่งช่วยลดความเสี่ยงของการเกิดโรคต้อกระจกได้ถึง 29% (ลูทีน) \n7.ช่วยลดความเสี่ยงของการเกิดโรคจอประสาทตาเสื่อมและยังช่วยป้องกันการเสื่อมของศูนย์จอตาได้อีกด้วย \n8.ช่วยบำรุงโลหิต ธาตุเหล็กและธาตุโฟเลตในผักคะน้ามีความสำคัญต่อการสร้างเม็ดเลือดแดง \n9.ช่วยเพิ่มการไหลเวียนของโลหิต\n10.มีส่วนช่วยลดระดับคอเลสเตอรอล",
      "properties_eng":
          "1. Contains antioxidants thus helping to slow down the degeneration of various cells in the body\n2. Help strengthen immunity in the body. make you healthy\n3. Help nourish skin and prevent various infections.\n4. Kale contains vitamin C. Which contributes to strengthening the tissue to be more moist (Vitamin C)\n5. Help nourish and maintain eyesight (vitamin A).\n6. Kale contains lutein (Lutein), which reduces the risk of cataracts by up to 29% (Lutein).\n7. Help reduce the risk of degenerative retinopathy and also prevent degeneration of the retinal center.\n8. Help nourish blood. Iron and folate in kale are important for the formation of red blood cells.\n9. Improves blood circulation.\n10. It helps reduce cholesterol levels.",
      "url_img": "assets/images/Kai-Lan.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%9c%e0%b8%b1%e0%b8%81%e0%b8%84%e0%b8%b0%e0%b8%99%e0%b9%89%e0%b8%b2\/"
    },
    {
      "id": 28,
      "name_th": "แมงลัก",
      "name_eng": "Lemon basil",
      "category": "Leaves",
      "properties_th":
          "1.เมื่อรับประทานเป็นประจำจะช่วยลดความเสี่ยงจากการเป็นโรคหัวใจ\n2.เม็ดแมงลักเป็นอาหารที่เหมาะกับผู้ป่วยโรคเบาหวาน เพราะช่วยทำให้การดูดซึมของน้ำตาลลดลง เนื่องจากเม็ดแมงลักทำให้ร่างกายดูดซึมสารอาหารได้ช้าลงอยู่แล้ว \n3.เม็ดแมงลักเป็นอาหารที่รับประทานง่าย กลืนง่าย ลื่นคอ และเหมาะสำหรับผู้ที่ไม่ค่อยรับประทานอาหารที่มีกากใยอย่างพวก ผักผลไม้ \n4.ช่วยให้ระบบขับถ่ายทำงานได้เป็นปกติและมีประสิทธิภาพ ขับถ่ายสะดวก 5.เม็ดแมงลัก สรรพคุณล้างลำไส้ ช่วยดีท็อกซ์แก้ปัญหาอุจจาระตกค้าง ซึ่งเป็นสาเหตุมาจากการเคี้ยวอาหารไม่ละเอียด รับประทานอาหารที่มีกากใยน้อย มีพยาธิ ระบบย่อยอาหารผิดปกติ ระบบดูดซึมเสีย และขับถ่ายไม่เป็นเวลา (ช่วงเช้า 05.00 – 07.00 น.) \n6.ใบแมงลักช่วยแก้อาการวิงเวียนศีรษะได้ \n7.ใบแมงลักมีสรรพคุณในการช่วยขับเหงื่อ \n8.ช่วยแก้อาการท้องอืดท้องเฟ้อ ด้วยการใช้ใบสดมาล้างน้ำให้สะอาดแล้วรับประทาน \n9.ใบแมงลักมีฤทธิ์ช่วยขับลมในลำไส้ ใช้เป็นยาระบาย กระตุ้นการขับถ่ายให้ดีขึ้น โดยการรับประทานเม็ดแมงลักก่อนเข้านอน ใบแมงลักต้มกับน้ำดื่มเป็นประจำช่วยรักษาโรคเกี่ยวกับลำไส้หรือทางเดินอาหารได้ \n10.ใบแมงลักมีฤทธิ์ช่วยยับยั้งเชื้อราและเชื้อแบคทีเรียบางชนิดได้ รักษาโรคกลากเกลื้อนด้วยการใช้ใบสดประมาณ 10 ใบ ล้างน้ำให้สะอาดแล้วนำมาตำผสมน้ำเล็กน้อย แล้วทาบริเวณที่เป็นกลากเกลื้อนวันละ 1 ครั้งประมาณ 1-2 สัปดาห์อาการจะดีขึ้น",
      "properties_eng":
          "1. When eaten regularly, it reduces the risk of heart disease.\n2. Basil seeds are suitable food for diabetics. because it helps reduce the absorption of sugar Because basil seeds cause the body to absorb nutrients more slowly.\n3. Basil seeds are foods that are easy to eat, easy to swallow, smooth and suitable for those who rarely eat fiber foods such as fruits and vegetables.\n4.Helps the excretory system to function normally and efficiently, excreting easily. 5.Basil seeds, cleansing properties. Helps to detoxify residual fecal problems. which is caused by not chewing food thoroughly Eating a diet that is low in fiber, has worms, has a digestive system disorder. waste absorption system and excretion is not time (in the morning 05.00 – 07.00)\n6. Basil leaves can help relieve dizziness.\n7. Basil leaves have properties to help sweat.\n8. Helps to relieve flatulence. By using fresh leaves to wash thoroughly and eat.\n9. Basil leaves have the effect of helping to drive wind in the intestines. used as a laxative Encourage better excretion by eating basil seeds before going to bed Regularly boiled basil leaves with drinking water can help treat intestinal or gastrointestinal ailments.\n10. Basil leaves have the effect of inhibiting some types of fungi and bacteria. Treat ringworm disease by using about 10 fresh leaves, washed with water, then pounded and mixed with a little water. Then apply on the ringworm area 1 time a day for about 1-2 weeks, the symptoms will improve.",
      "url_img": "assets/images/Lemon basil.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b9%81%e0%b8%a1%e0%b8%87%e0%b8%a5%e0%b8%b1%e0%b8%81\/"
    },
    {
      "id": 29,
      "name_th": "มะรุม",
      "name_eng": "Moringa",
      "category": "Fruit",
      "properties_th":
          "1.ช่วยบำรุงผิวพรรณให้ชุ่มชื้น อ่อนนุ่ม ไม่ให้หยาบกร้าน \n2.มีสารต่อต้านอนุมูลอิสระช่วยในการชะลอวัย (น้ำมันมะรุม) \n3.ช่วยเสริมสร้างภูมิคุ้มกันให้แก่ร่างกาย \n4.ช่วยรักษาโรคขาดสารอาหารในเด็กแรกเกิดถึงอายุ 10 ขวบ \n5.ช่วยลดไขมันและคอเลสเตอรอลในร่างกาย (ฝัก) \n6.มีส่วนช่วยป้องกันโรคมะเร็ง (ใบ, ดอก, ฝัก, เมล็ด, เปลือกของลำต้น) \n7.ช่วยรักษาโรคมะเร็งในกระดูก \n8.ผู้ป่วยมะเร็งที่ได้รับการรักษาด้วยรังสี การดื่มน้ำมะรุมจะช่วยให้อาการแพ้รังสีฟื้นตัวเร็วขึ้น \n9.ช่วยเพิ่มการไหลเวียนของโลหิตในร่างกาย \n10.ช่วยรักษาโรคโลหิตจาง",
      "properties_eng":
          "1. Help nourish the skin to be moisturized, soft, not rough.\n2. Contains anti-oxidants to help slow down aging. (moringa oil)\n3. Help strengthen the body's immunity.\n4. Helps treat malnutrition in children from birth to 10 years old.\n5. Help reduce fat and cholesterol in the body (pods).\n6. Helps prevent cancer (leaves, flowers, pods, seeds, bark of the trunk)\n7. Help cure bone cancer.\n8. Cancer patients receiving radiation therapy Drinking moringa juice can speed up recovery from radiation allergy.\n9. Improves blood circulation in the body.\n10. Help cure anemia.",
      "url_img": "assets/images/Moringa.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%a1%e0%b8%b0%e0%b8%a3%e0%b8%b8%e0%b8%a1\/"
    },
    {
      "id": 30,
      "name_th": "ตะไคร้",
      "name_eng": "Lemongrass",
      "category": "Stalk",
      "properties_th":
          "1.มีส่วนช่วยในการขับเหงื่อ \n2.เป็นยาบำรุงธาตุไฟให้เจริญ (ต้นตะไคร้) \n3.มีสรรพคุณเป็นยาบำรุงธาตุ \n4.ช่วยในการเจริญอาหาร \n5.ช่วยแก้อาการเบื่ออาหาร (ต้น) \n6.สารสกัดจากตะไคร้มีส่วนช่วยในการป้องกันโรคมะเร็งลำไส้ใหญ่ \n7.แก้และบรรเทาอาการหวัด อาการไอ \n8.ช่วยรักษาอาการไข้ (ใบสด) \n9.ใช้เป็นยาแก้ไข้เหนือ (ราก) \n10.น้ำมันหอมระเหยของใบตะไคร้สามารถบรรเทาอาการปวดได้ \nช่วยแก้อาการปวดศีรษะ",
      "properties_eng":
          "1. contributes to sweating\n2. As a tonic for the fire element to prosper (Lemongrass tree)\n3. Has properties as a tonic\n4. Helps in appetite.\n5. Helps to relieve anorexia (early)\n6. Lemongrass extracts contribute to the prevention of colon cancer.\n7. Fix and relieve cold symptoms, cough.\n8.Help treat fever (fresh leaves)\n9. Used as a fever remedy above (root).\n10. Lemongrass essential oil can relieve pain.\nhelp relieve headache",
      "url_img": "assets/images/Lemongrass.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%95%e0%b8%b0%e0%b9%84%e0%b8%84%e0%b8%a3%e0%b9%89\/"
    },
    {
      "id": 31,
      "name_th": "พริกไทย",
      "name_eng": "Pepper",
      "category": "Fruit",
      "properties_th":
          "1.เมล็ดพริกไทยมีสารฟีนอลิกและสารพิเพอรีน ซึ่งช่วยต่อต้านอนุมูลอิสระ \n2.เมล็ดพริกไทยมีสารพิเพอรีน (Piperine) ซึ่งเป็นสารอัลคาลอยด์ที่มีส่วนช่วยรักษาและป้องกันการเกิดโรคอัลไซเมอร์ในผู้สูงอายุได้\n3.ช่วยป้องกันและต่อต้านสารก่อมะเร็ง \n4.ช่วยเร่งการทำงานของตับให้ทำลายสารพิษได้มากขึ้น \n5.เมล็ดพริกไทยมีฤทธิ์ในการช่วยกระตุ้นประสาท\n6.ช่วยแก้โรคลมบ้าหมูหรือลมชักได้ \n7.ช่วยบำรุงธาตุในร่างกาย \n8.ช่วยทำให้เจริญอาหาร ทำให้ลิ้นของผู้สูงอายุรับรสได้ดียิ่งขึ้น \n9.ช่วยบรรเทาอาการนอนไม่หลับ \n10.ช่วยเพิ่มความอบอุ่นให้กับร่างกายและเสริมภูมิต้านทานไปด้วยในตัว ",
      "properties_eng":
          "1. Pepper seeds contain phenolic and piperine substances. which help neutralize free radicals\n2. Pepper seeds contain piperine (Piperine), an alkaloid substance that can help treat and prevent Alzheimer's disease in the elderly.\n3. Help prevent and resist carcinogens.\n4. Help speed up liver function to destroy more toxins.\n5. Pepper seeds have the effect of stimulating the nerves.\n6. It can help cure epilepsy or epilepsy.\n7. Help nourish the elements in the body.\n8. Helps to make appetite. It makes the tongue of the elderly taste better.\n9. Help relieve insomnia.\n10. Helps increase warmth to the body and enhance immunity in itself.",
      "url_img": "assets/images/Pepper.jpg",
      "url":
          "https:\/\/medthai.com\/%E0%B8%9E%E0%B8%A3%E0%B8%B4%E0%B8%81%E0%B9%84%E0%B8%97%E0%B8%A2\/"
    },
    {
      "id": 32,
      "name_th": "ทับทิม",
      "name_eng": "Pomegranate",
      "category": "Fruit",
      "properties_th":
          "1.ช่วยบำรุงผิวพรรณให้เปล่งปลั่งสดใส \n2.ช่วยต่อต้านอนุมูลอิสระในร่างกายและช่วยในการชะลอวัย \n3.น้ำทับทิมมีคุณสมบัติช่วยให้ผิวหน้าเต่งตึง ด้วยการนำน้ำทับทิมประมาณ 1 ช้อนชามาทาทิ้งไว้บนใบหน้าประมาณ 10 นาทีแล้วล้างออก \n4.น้ำทับทิมช่วยเพิ่มความสดชื่น แก้กระหาย คลายร้อนได้เป็นอย่างดี \n5.ช่วยระงับกลิ่นปากได้อีกด้วย \n6.ช่วยเสริมสร้างภูมิคุ้มกันให้แข็งแรง บรรเทาอาการหวัด \n7.ช่วยปกป้องผิวของคุณจากแสงแดด ทับทับมีวิตามินซีสูงมาก และยังมีวิตามินเอ วิตามินอี และกรดโฟลิกอีกด้วย \n8.ช่วยบรรเทาอาการแพ้ท้องในหญิงตั้งครรภ์\n9.ช่วยในการปรับฮอร์โมนวัยหมดประจำเดือน \n10.ช่วยป้องกันโรคความจำเสื่อมในผู้สูงอายุ",
      "properties_eng":
          "1. Help nourish the skin to be radiant and bright.\n2. Helps neutralize free radicals in the body and helps to slow down aging.\n3. Pomegranate juice has properties to help firm facial skin. By bringing about 1 teaspoon of pomegranate juice to apply and leave on the face for about 10 minutes, then rinse.\n4. Pomegranate juice helps to increase freshness, relieve thirst, cool down very well.\n5. It can also help stop bad breath.\n6. Help strengthen immunity. relieve cold symptoms\n7. Help protect your skin from sunlight. Thap Thap is very high in vitamin C. It also contains vitamin A, vitamin E and folic acid.\n8. Help relieve morning sickness in pregnant women.\n9. Helps to adjust menopausal hormones.\n10. Help prevent dementia in the elderly.",
      "url_img": "assets/images/Pomegranate.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%97%e0%b8%b1%e0%b8%9a%e0%b8%97%e0%b8%b4%e0%b8%a1\/"
    },
    {
      "id": 33,
      "name_th": "ดอกโสน",
      "name_eng": "Sesbania",
      "category": "Flower",
      "properties_th":
          "1.ดอกโสนมีรสจืด มัน เย็น มีสรรพคุณเป็นยาแก้พิษร้อน ถอนพิษไข้ \n2.รากโสนมีรสจืด มีสรรพคุณเป็นยาแก้ร้อนในกระหายน้ำ \n3.ดอกมีสรรพคุณเป็นยาสมานลำไส้ \n4.ใช้แก้อาการปวดมวนท้อง \n5.ต้นโสนมีรสจืด แพทย์แผนโบราณจะนำต้นมาเผาให้เกรียม แล้วนำมาแช่น้ำให้เป็นด่าง ใช้ดื่มเป็นยาขับปัสสาวะ \n6.ใบใช้ตำเป็นยาพอกแผล ส่วนดอกก็สามารถนำมาปรุงเป็นยาพอกแผลได้เช่นกัน \n7.ใบโสนมีรสจืดเย็น นำมาตำผสมกับดินประสิวและดินสอพอง ใช้เป็นยาพอกแก้ปวดฝี ช่วยถอนพิษ\n8.ดอกใช้เป็นยาถอนพิษจากแมลงสัตว์กัดต่อย ",
      "properties_eng":
          "1. Sesbania flowers are tasteless, it is cool, has properties as an antidote to heat, neutralizes fever.\n2. Sesbania root has a tasteless taste. Has properties as a hot remedy for thirsty\n3. Flowers have properties as an astringent for the intestines.\n4. Used to relieve abdominal pain.\n5. Sesbania has a tasteless taste. Traditional medicine will bring the tree to burn to scorch. Then soaked in water to make it alkaline. Drink as a diuretic\n6. The leaves are used as a poultice for wounds. The flowers can be cooked as a poultice as well.\n7. Sesbania leaves are tasteless and cool. The pound was mixed with saltpeter and chalk. Used as a poultice to relieve pain, abscesses and help neutralize poison.\n8. Flowers are used as an antidote from insect bites.",
      "url_img": "assets/images/Sesbania.jpg",
      "url": "https:\/\/medthai.com\/%e0%b9%82%e0%b8%aa%e0%b8%99\/"
    },
    {
      "id": 34,
      "name_th": "ขี้เหล็ก",
      "name_eng": "Siamese senna",
      "category": "Flower",
      "properties_th":
          "1.ใบขี้เหล็กมีแคลเซียมและฟอสฟอรัสสูง ช่วยเสริมสร้างกระดูกและฟันให้แข็งแรง\n2.ดอกขี้เหล็กมีวิตามินที่ช่วยบำรุงและรักษาสายตา\n3.ช่วยเสริมสร้างภูมิต้านทานโรค ป้องกันหวัด ช่วยทำให้แผลหายเร็วขึ้น\n4.ช่วยบำรุงธาตุ  \n5.แก้ธาตุพิการ แก้ไฟ ทำให้ตัวเย็น\n6.ช่วยเจริญธาตุไฟ \n7.ช่วยแก้โรคกระษัย\n8.ช่วยรักษาอาการตัวเหลือง\n9.ช่วยรักษาโรคเบาหวาน \n10.ช่วยลดความดันโลหิตสูง",
      "properties_eng":
          "1. Cassia leaves are high in calcium and phosphorus. Helps strengthen bones and teeth\n2. Cassia flowers contain vitamins that help nourish and maintain eyesight.\n3. Help strengthen immunity, prevent colds, help wounds heal faster.\n4. Help nourish the elements.\n5. Fix disabilities, fix fire, make the body cool.\n6. Help prosper the fire element.\n7. Help cure wasting disease.\n8. Help cure jaundice.\n9. Help cure diabetes.\n10. Help reduce high blood pressure.",
      "url_img": "assets/images/Siamese senna.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%82%e0%b8%b5%e0%b9%89%e0%b9%80%e0%b8%ab%e0%b8%a5%e0%b9%87%e0%b8%81\/"
    },
    {
      "id": 35,
      "name_th": "หญ้าหวาน",
      "name_eng": "Stevia",
      "category": "Leaves",
      "properties_th":
          "1.สมุนไพรหญ้าหวานช่วยเพิ่มกำลังวังชา \n2.ช่วยให้เลือดไปเลี้ยงสมองมากขึ้น \n3.ช่วยในการรักษาผู้ป่วยโรคเบาหวาน \n4.ลดระดับน้ำตาลในเส้นเลือด \n5.เหมาะสำหรับผู้ที่ต้องการควบคุมระดับน้ำตาลในเลือด \n6.ช่วยลดไขมันในเลือดสูง \n7.ช่วยลดความเสี่ยงของการเกิดโรคหัวใจ \n8.ความดันโลหิตสูง และโรคอ้วน ช่วยบำรุงตับ \n9.ช่วยสมานแผลทั้งภายในและภายนอก",
      "properties_eng":
          "1. Stevia herbs help increase strength.\n2. Helps more blood to raise the brain.\n3. Helps in the treatment of diabetics.\n4. Reduce blood sugar levels.\n5. Suitable for those who want to control blood sugar levels.\n6. Help reduce high blood fat.\n7. Help reduce the risk of heart disease.\n8. High blood pressure and obesity help nourish the liver.\n9. Help heal wounds both inside and outside.",
      "url_img": "assets/images/Stevia.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%ab%e0%b8%8d%e0%b9%89%e0%b8%b2%e0%b8%ab%e0%b8%a7%e0%b8%b2%e0%b8%99\/"
    },
    {
      "id": 36,
      "name_th": "อ้อย",
      "name_eng": "Sugarcane",
      "category": "Stalk",
      "properties_th":
          "1.ช่วยบำรุงร่างกาย รักษาอาการอ่อนเพลีย รักษาอาการผอมแห้ง หิวและหอบ ไม่มีเรี่ยวแรง\n2.ใช้เป็นยาบำรุงกำลัง ทำให้เกิดกำลัง\n3.ช่วยบำรุงธาตุ เจริญธาตุ ผายธาตุในร่างกาย \n4.ช่วยบำรุงธาตุน้ำ\n5.ช่วยบำรุงธาตุทั้งสี่ บำรุงอาโปธาตุ\n6.ช่วยบำรุงโลหิต\n7.ช่วยดับพิษโลหิตแดงอักเสบ \n8.ช่วยรักษาเลือดลม\n9.ช่วยบำรุงหัวใจ \n10.ช่วยรักษาอาการอ่อนเพลีย",
      "properties_eng":
          "1. Help nourish the body. treat exhaustion Treatment of emaciation, hunger and panting, lack of energy\n2. Used as a tonic energize\n3. Help nourish the elements, prosper the elements, the elements in the body.\n4. Help nourish the water element.\n5. Help nourish the four elements. nourish the apothecary\n6. Help nourish blood.\n7. Help extinguish red blood poisoning.\n8. Help maintain blood, wind.\n9. Help nourish the heart.\n10. Help cure exhaustion.",
      "url_img": "assets/images/Sugarcane.jpg",
      "url": "https:\/\/medthai.com\/%E0%B8%AD%E0%B9%89%E0%B8%AD%E0%B8%A2\/"
    },
    {
      "id": 37,
      "name_th": "บอระเพ็ด",
      "name_eng": "Tinospora crispa",
      "category": "Stalk",
      "properties_th":
          "1.บอระเพ็ดช่วยบำรุงผิวพรรณให้สดใส หน้าตาสดชื่น\n2.มีสารต้านอนุมูลอิสระ มีส่วนช่วยในการชะลอวัย \n3.ประโยชน์ของบอระเพ็ด ช่วยให้ผมดกหนาขึ้นและอาการผมหงอก ผมร่วงก็จะลดน้อยลง ซึ่งจะได้ผลดีอย่างมากกับผู้ที่มีอาการผมหงอกก่อนวัย หากรับประทานผงบอระเพ็ดวันละ 600 mg. เป็นเวลา 1 เดือน \n4.แก้อาการคันหนังศีรษะ รังแค ชันนะตุ ใช้แก้อาการกระหายน้ำ \n5.ใช้เป็นยาบำรุงธาตุ บำรุงร่างกาย\n6.ช่วยให้สุขภาพร่างกายแข็งแรง เสริมสร้างภูมิต้านทาน \n7.บอระเพ็ดลดความอ้วน\n8.ใช้รักษาโรคมะเร็งเม็ดเลือด \n9.ช่วยรักษาอาการโลหิตคั่งในสมอง \n10.ช่วยให้เจริญอาหาร",
      "properties_eng":
          "1. Borapet helps nourish the skin to be bright and fresh.\n2. Contains antioxidants Contributes to anti-aging\n3.Benefits of wormwood Helps thicker hair and gray hair Hair loss will be reduced. This will be very effective for people with premature gray hair. If taking wormwood powder 600 mg. per day for 1 month\n4. Relieve itchy scalp, dandruff. Channatu is used to relieve thirst.\n5. Used as an elemental tonic to nourish the body.\n6. Helps to keep your body healthy. strengthen immunity\n7. Borapet to lose weight\n8. Used to treat leukemia.\n9. Helps treat congestion in the brain.\n10. Helps appetite.",
      "url_img": "assets/images/Tinospora crispa.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%9a%e0%b8%ad%e0%b8%a3%e0%b8%b0%e0%b9%80%e0%b8%9e%e0%b9%87%e0%b8%94\/"
    },
    {
      "id": 38,
      "name_th": "ขมิ้น",
      "name_eng": "Turmeric",
      "category": "Roots",
      "properties_th":
          "1.ขมิ้นมีสารต่อต้านอนุมูลอิสระซึ่งช่วยในการชะลอวัยและชะลอการเกิดริ้วรอย \n2.ช่วยเสริมสร้างภูมิต้านทานให้กับร่างกาย \n3.ช่วยเสริมสร้างภูมิคุ้มกันให้ผิวหนังมีสุขภาพดีแข็งแรง \n4.ขมิ้นชันอาจมีบทบาทช่วยป้องกันการเกิดโรคมะเร็ง เช่น โรคมะเร็งลำไส้ มะเร็งปากมดลูก \n5.ขมิ้นสามารถช่วยลดระดับคอเลสเตอรอลในร่างกายได้ \n6.ช่วยกำจัดสารพิษออกจากร่างกาย \n7.ช่วยบรรเทาอาการของโรคเบาหวาน \n8.มีส่วนช่วยรักษาโรคความดันโลหิตสูง \n9.ช่วยลดอาการของโรคเกาต์ \n10.ช่วยขับน้ำนมของมารดาหลังคลอดบุตร",
      "properties_eng":
          "1. Turmeric contains anti-oxidants which help to slow down aging and slow down wrinkles.\n2. Help strengthen the immune system for the body.\n3. Help strengthen immunity for healthy skin.\n4. Turmeric may play a role in preventing cancer such as colon cancer. cervical cancer\n5. Turmeric can help reduce cholesterol levels in the body.\n6. Help eliminate toxins from the body.\n7. Helps relieve symptoms of diabetes.\n8. contributes to the treatment of hypertension\n9. Help reduce symptoms of gout.\n10. Help drive mother's milk after giving birth.",
      "url_img": "assets/images/Turmeric.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%82%e0%b8%a1%e0%b8%b4%e0%b9%89%e0%b8%99%e0%b8%8a%e0%b8%b1%e0%b8%99\/"
    },
    {
      "id": 39,
      "name_th": "เงาะ",
      "name_eng": "Rambutan",
      "category": "Fruit",
      "properties_th":
          "1.เงาะมีส่วนช่วยบำรุงผิวพรรณให้เปล่งปลั่งสดใส\n2.ช่วยรักษาอาการอักเสบในช่องปาก\n3.ช่วยแก้อาการท้องร่วงรุนแรงอย่างได้ผล \n4.ช่วยรักษาโรคบิด ท้องร่วง \n5.ใช้เป็นยาแก้อักเสบ ช่วยฆ่าเชื้อแบคทีเรีย  \n6.ยับยั้งการเจริญเติบโตของจุลินทรีย์ ใช้ทำเป็นยารักษาโรค",
      "properties_eng":
          "1. Rambutan helps nourish the skin to shine brightly.\n2. Helps treat inflammation in the mouth.\n3. Helps to solve severe diarrhea effectively.\n4. Helps treat dysentery, diarrhea\n5. Used as an anti-inflammatory drug. help kill bacteria\n6. Inhibit the growth of microorganisms Used to make medicine",
      "url_img": "assets/images/Rambutan.jpg",
      "url": "https:\/\/medthai.com\/%e0%b9%80%e0%b8%87%e0%b8%b2%e0%b8%b0\/"
    },
    {
      "id": 40,
      "name_th": "เตย",
      "name_eng": "Pandan leaves",
      "category": "Leaves",
      "properties_th":
          "1.ช่วยบำรุงหัวใจให้ชุ่มชื่น และช่วยลดอัตราการเต้นของหัวใจ\n2.การดื่มน้ำใบเตยจะช่วยดับกระหายคลายร้อนได้เป็นอย่างดี เพราะใบเตยมีกลิ่นหอมเย็น ดื่มแล้วจึงรู้สึกสดชื่น ผ่อนคลาย \n3.รสหวานเย็นของใบเตยช่วยชูกำลังได้ \n4.การดื่มน้ำใบเตยช่วยแก้อาการอ่อนเพลียของร่างกายได้ \n5.ช่วยปรับสมดุลในร่างกาย \n6.ผู้ที่มีธาตุเจ้าเรือนเป็นธาตุไฟนั้น การรับประทานอาหารที่ปรุงจากใบเตยจะช่วยทำให้รู้สึกเย็นสบายสดชื่นได้ \n7.ช่วยรักษาโรคเบาหวาน ช่วยควบคุมระดับน้ำตาลในเลือด ซึ่งตามตำรับยาไทยได้มีการนำใบเตยหอม 32 ใบ, ใบของต้นสัก 9 ใบ นำมาหั่นตากแดด แล้วนำมาชงเป็นชาดื่มอย่างน้อย 1 เดือน หรือจะใช้รากประมาณ 1 กำมือนำมาต้มกับน้ำดื่มเช้าเย็นก็ได้เหมือนกัน\n8.ช่วยลดความดันโลหิต \n9.ช่วยป้องกันการแข็งตัวของหลอดเลือด \n10.ช่วยบรรเทาอาการอาการและดับพิษไข้ได้",
      "properties_eng":
          "1. Help nourish the heart to be moisturized. and reduces heart rate\n2. Drinking pandan juice will help quench thirst and cool down very well. Because pandan leaves have a cool aroma. Drink and then feel refreshed and relaxed.\n3. The sweet and cool taste of pandanus leaves can help boost energy.\n4. Drinking pandan juice can help relieve body exhaustion.\n5. Help balance the body.\n6. Those who have the element of the house as the fire element Eating food made from pandan leaves can help make you feel cool and refreshed.\n7. Help cure diabetes. Helps control blood sugar levels According to the Thai medicine formula, 32 pandanus leaves, 9 teak leaves have been sliced and dried in the sun. Then brew it as a tea and drink it for at least 1 month or use about 1 handful of roots to boil with drinking water in the morning and evening as well.\n8. Help reduce blood pressure.\n9. Help prevent hardening of blood vessels.\n10. It can help relieve symptoms and extinguish fever.",
      "url_img": "assets/images/Pandan leaves.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b9%83%e0%b8%9a%e0%b9%80%e0%b8%95%e0%b8%a2\/"
    },
    {
      "id": 41,
      "name_th": "สาบเสือ",
      "name_eng": "Siam weed",
      "category": "Leaves",
      "properties_th":
          "1.ดอกสาบเสือมีสรรพคุณช่วยชูกำลัง แก้อาการอ่อนเพลีย\n2.ช่วยบำรุงหัวใจ\n3.ช่วยแก้ตาฟาง ตาแฉะ\n4.ช่วยแก้กระหายน้ำ\n5.ดอกช่วยแก้ไข้\n6.รากสาบเสือใช้ผสมกับรากมะนาวและรากย่านาง นำมาต้มเป็นน้ำดื่มช่วยรักษาไข้ป่าได้  \n7.ดอกใช้เป็นยาแก้ร้อนใน \n8.ใช้เป็นยาแก้ปวดท้อง อาการท้องขึ้น ท้องเฟ้อ\n9.รากสาบเสือนำมาใช้ต้มเป็นน้ำดื่มช่วยแก้โรคกระเพาะได้ \n10.ช่วยแก้ริดสีดวงทวาร ",
      "properties_eng":
          "1. Sap Suea flowers have properties to help strengthen cure exhaustion\n2. Help nourish the heart.\n3.Helps to fix blurry eyes, watery eyes\n4. Help solve thirst.\n5. flowers help cure fever\n6. Sap Suea root is mixed with lime root and Yanang root. Bring to boil as drinking water to help cure forest fever.\n7. Flowers are used as a hot remedy in\n8. Used as a pain reliever. Abdominal pain, flatulence\n9. Tiger bark can be used to boil as drinking water to help cure gastritis.\n10. Helps to cure hemorrhoids.",
      "url_img": "assets/images/Siam weed.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%aa%e0%b8%b2%e0%b8%9a%e0%b9%80%e0%b8%aa%e0%b8%b7%e0%b8%ad\/"
    },
    {
      "id": 42,
      "name_th": "สะระแหน่",
      "name_eng": "Marsh Mint",
      "category": "Leaves",
      "properties_th":
          "1.ช่วยให้ผิวชุ่มชื้นด้วยการนำใบสะระแหน่มาบดแล้วนำมาทาผิว \n2.ช่วยกำจัดอนุมูลอิสระออกจากร่างกาย \n3.ใช้เป็นยาเย็น ดับร้อน และขับเหงื่อในร่างกาย \n4.ช่วยบำรุงและรักษาสายตา \n5.ช่วยลดรอยคล้ำใต้ตาด้วยการนำใบสะระแหน่มาบดให้ละเอียดโดยเติมน้ำระหว่างบดด้วยเล็กน้อย แล้วใส่น้ำผึ้งตามลงไป คลุกเคล้าให้เข้ากัน แล้วนำมาทาใต้ตาทิ้ง ไว้ประมาณ 15 นาทีแล้วล้างออก \n6.ช่วยบรรเทาอาการเครียด \n7.ช่วยรักษาอาการปวดศีรษะ ไมเกรน ช่วยให้สมองปลอดโปร่ง โล่งคอ ด้วยการดื่มน้ำใบสะระแหน่ 5 กรัมกับน้ำ 1 ถ้วย ผสมเกลือเล็กน้อย วันละ 2 ครั้ง \n8.ช่วยแก้อาการหน้ามืดตาลาย ด้วยการดื่มน้ำต้มใบสะระแหน่กับขิงสด \n9.ช่วยบรรเทาอาการและแก้หวัด น้ำมูกไหล อาการไอ \n10.ช่วยรักษาโรคหอบหืด",
      "properties_eng":
          "1. Helps to moisturize the skin by crushing mint leaves and applying them to the skin.\n2. Help eliminate free radicals from the body.\n3. Used as a cold medicine to extinguish heat and sweat in the body.\n4. Help nourish and maintain eyesight.\n5. Help reduce dark circles under the eyes by bringing mint leaves to grind thoroughly by adding a little water during grinding. and then add honey to it mix well Then apply it under the eyes and leave it for about 15 minutes, then rinse.\n6. Help relieve stress.\nHelps treat headaches, migraines, clears the brain, clears the throat by drinking 5 grams of mint leaf juice with 1 cup of water, mixed with a little salt, twice a day.\n8. Helps to cure dizzy, dizzy. by drinking mint leaves with fresh ginger\n9. Helps relieve symptoms and cure colds, runny nose, cough.\n10. Help cure asthma.",
      "url_img": "assets/images/Marsh Mint.jpg",
      "url":
          "https:\/\/medthai.com\/%E0%B8%AA%E0%B8%B0%E0%B8%A3%E0%B8%B0%E0%B9%81%E0%B8%AB%E0%B8%99%E0%B9%88\/"
    },
    {
      "id": 43,
      "name_th": "ฟ้าทะลายโจร",
      "name_eng": "Kariyat",
      "category": "Leaves",
      "properties_th":
          "1.สรรพคุณฟ้าทะลายโจรช่วยต่อต้านอนุมูลอิสระในร่างกาย ช่วยกระตุ้นการสร้างภูมิคุ้มกันในร่างกาย ต่อต้านสิ่งแปลกปลอมที่เข้ามาในร่างกาย รวมไปถึงช่วยกระตุ้นการสร้างเม็ดเลือดขาวให้จับกินเชื้อโรคได้ดียิ่งขึ้นอีกด้วย \n2.สรรพคุณฟ้าทะลายโจรมีฤทธิ์ช่วยยับยั้งการเจริญเติบโตของเซลล์มะเร็ง 3.สรรพคุณฟ้าทะลายโจร ใบใช้เป็นยาขมช่วยทำให้เจริญอาหาร \n4.ช่วยรักษาโรคเบาหวาน ด้วยการใช้ต้นฟ้าทะลายโจร กระชาย และว่านเอ็นเหลือง นำมาทำเป็นยาเม็ดลูกรับประทาน \n5.ช่วยป้องกันและแก้อาการหวัด คัดจมูก ด้วยการใช้ใบและกิ่งประมาณ 1 กำมือ (สดใช้ 25 กรัม แต่ถ้าแห้งใช้ 3 กรัม) นำมาต้มกับน้ำดื่ม รับประทานก่อนอาหารวันละ 2 ครั้ง เช้าและเย็น หรือในขณะที่มีอาการ \n6.ช่วยแก้อาการปวดหัวตัวร้อน อาการปวดหัวแบบไม่มีสาเหตุ ด้วยการใช้ใบและกิ่งประมาณ 1 กำมือ (สดใช้ 25 กรัม แต่ถ้าแห้งใช้ 3 กรัม) นำมาต้มกับน้ำดื่มก่อนอาหารวันละ 2 ครั้ง เช้าและเย็น หรือในขณะที่มีอาการ\n7.ฟ้าทะลายโจร สรรพคุณช่วยแก้ไข้ทั่ว ๆ ไป อาการปวดหัวตัวร้อน เช่น ไข้หวัด ไข้หวัดใหญ่ เป็นต้น\n8.ช่วยรักษาไข้ไทฟอยด์ ด้วยการรับประทานฟ้าทะลายโจรก่อนอาหารครั้งละ 2 เม็ด วันละ 3 ครั้ง เป็นเวลา 3 สัปดาห์ หลังจากนั้นให้กินยาบำรุงเพื่อฟื้นฟูกำลังของผู้ป่วยร่วมด้วย \n9.ช่วยแก้อาการไอ ลดน้ำมูก และช่วยฆ่าเชื้อที่จมูก ด้วยการใช้ใบนำมาทำเป็นยาผงแล้วนำมาใช้สูดดม \n10.ช่วยลดและขับเสมหะ ด้วยการใช้ใบนำมาทำเป็นยาผงแล้วนำมาใช้สูดดม",
      "properties_eng":
          "1. Properties of Andrographis paniculata helps neutralize free radicals in the body. Stimulates the immune system in the body. Against foreign matter that enters the body Including helping to stimulate the production of white blood cells to capture pathogens better as well\n2. The properties of Andrographis Paniculata have the effect of inhibiting the growth of cancer cells. 3.Properties of the sky paniculata The leaves are used as a bitter medicine to help increase appetite.\n4. Help cure diabetes. With the use of the Fah Paniculata, Krachai and Yellow tendon Used to make pills for children to eat\n5. Helps prevent and cure colds, nasal congestion by using about 1 handful of leaves and twigs (25 grams fresh, but 3 grams dry). Bring to boil with drinking water. Take before meals 2 times a day, morning and evening, or while having symptoms.\n6. Help relieve headache, hot body. headache without cause By using about 1 handful of leaves and twigs (25 grams fresh, but 3 grams dry), boiled with drinking water before meals 2 times a day, morning and evening, or while having symptoms.\n7. Fah Talai Thieves Efficacy helps to cure general fever, headache, hot body such as flu, influenza, etc.\n8. Help cure typhoid fever. By taking andrographis paniculata before meals, 2 tablets 3 times a day for 3 weeks, after that, take a tonic to restore the patient's strength.\n9. Help cure cough, reduce snot and help disinfect the nose. By using the leaves to make a powdered medicine and then use it for inhalation.\n10. Help reduce and drive phlegm. By using the leaves to make a powdered medicine and then use it for inhalation.",
      "url_img": "assets/images/Kariyat.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%9f%e0%b9%89%e0%b8%b2%e0%b8%97%e0%b8%b0%e0%b8%a5%e0%b8%b2%e0%b8%a2%e0%b9%82%e0%b8%88%e0%b8%a3\/"
    },
    {
      "id": 44,
      "name_th": "ชะพลู",
      "name_eng": "Wildbetal leafbush",
      "category": "Leaves",
      "properties_th":
          "1.ช่วยต่อต้านอนุมูลอิสระต่าง ๆ\n2.ใบชะพลูมีรสเผ็ดร้อน ช่วยทำให้เจริญอาหารมากยิ่งขึ้น \n3.ใบชะพลูมีเบต้าแคโรทีนในปริมาณมากซึ่งช่วยบำรุงและรักษาสายตา ช่วยในการมองเห็น ป้องกันโรคตาบอดตอนกลางคืน แก้โรคตาฟาง เป็นต้น \n4.ช่วยยับยั้งและชะลอการขยายตัวของเซลล์มะเร็ง \n5.ช่วยรักษาโรคเบาหวาน ด้วยการใช้ชะพลูสดทั้งต้นประมาณ 7 ต้น นำมาล้างน้ำให้สะอาด ใส่น้ำพอท่วมแล้วต้มให้เดือดสักพัก แล้วนำมาดื่มเป็นชา\n6.ช่วยบำรุงธาตุ แก้ธาตุพิการ \n7.ช่วยบำรุงกระดูกและฟัน และช่วยป้องกันการเกิดโรคกระดูกพรุน\n8.ช่วยทำให้เสมหะงวดและแห้ง \n9.ช่วยในการขับเสมหะบริเวณทรวงอก ลำคอ \n10.ช่วยในการขับเสมหะทางอุจจาระ ",
      "properties_eng":
          "1. Helps neutralize various free radicals\n2. Cha Phlu leaves have a spicy taste. Helps to increase appetite\n3. Chaplu leaves contain large amounts of beta-carotene, which helps nourish and maintain eyesight. helps to see Prevent night blindness, cure eye disease, etc.\n4. Help stop and slow down the growth of cancer cells.\n5. Help cure diabetes. By using about 7 fresh chaplu trees, they are washed with clean water. Add enough water to cover and boil for a while. and then drink as tea\n6. Help nourish the elements, fix the disabilities.\n7. Help nourish bones and teeth. and helps prevent osteoporosis\n8. Helps make sputum tight and dry.\n9. Helps to drive phlegm around the chest and throat.\n10. Helps to drive fecal phlegm.",
      "url_img": "assets/images/Wildbetal leafbush.jpg",
      "url":
          "https:\/\/medthai.com\/%E0%B8%8A%E0%B8%B0%E0%B8%9E%E0%B8%A5%E0%B8%B9\/"
    },
    {
      "id": 45,
      "name_th": "โหระพา",
      "name_eng": "Sweet basil",
      "category": "Leaves",
      "properties_th":
          "1.ใบสดโหระพาใช้เป็นน้ำมันหอมระเหย \n2.ช่วยป้องกันความเสียหายในร่างกายของเราจากการทำลายของอนุมูลอิสระ \n3.ช่วยกระตุ้นการสร้างภูมิคุ้มกันให้แก่ร่างกาย \n4.มีส่วนในการช่วยป้องกันโรคหัวใจขาดเลือด \n5.มีฤทธิ์ในการช่วยลดคอเลสเตอรอลและแผ่นคราบพลัคในกระแสเลือด \n6.มีส่วนช่วยป้องกันการเกิดโรคมะเร็ง \n7.ช่วยขับหัวสิวและต้านการเจริญเติบโตของเชื้อสิว \n8.ช่วยในการเจริญอาหาร \n9.ใช้เป็นยาพอกเพื่อดูดซับสารพิษออกจากผิวหนังได้ \n10.ช่วยเพิ่มปริมาณน้ำนมสำหรับมารดาที่ให้นมบุตร",
      "properties_eng":
          "1. Fresh basil leaves are used as essential oils.\n2. Help prevent damage in our body from the destruction of free radicals.\n3. Stimulates the immune system for the body.\n4. contribute to help prevent ischemic heart disease\n5. It has the effect of helping reduce cholesterol and plaque in the blood stream.\n6. It helps prevent cancer.\n7. Help drive acne and resist the growth of acne.\n8. Helps in appetite.\n9. It can be used as a poultice to absorb toxins from the skin.\n10. Helps increase the amount of milk for breastfeeding mothers.",
      "url_img": "assets/images/Sweet basil.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b9%82%e0%b8%ab%e0%b8%a3%e0%b8%b0%e0%b8%9e%e0%b8%b2\/"
    },
    {
      "id": 46,
      "name_th": "พลู",
      "name_eng": "Plu Kaow",
      "category": "Leaves",
      "properties_th":
          "1.มีฤทธิ์ในการช่วยต่อต้านมะเร็ง ยับยั้งการเจริญเติบโตของเซลล์มะเร็ง \n2.มีฤทธิ์ในการช่วยบำบัดฟื้นฟูโรคความดันโลหิตสูง \n3.ช่วยเสริมสร้างภูมิคุ้มกันให้กับร่างกาย ต้านทานโรค \n4.ช่วยยืดอายุผู้ป่วยให้อยู่สู้โรคได้นานมากขึ้น \n5.มีส่วนช่วยยับยั้งเบาหวาน รักษาความสมดุลของร่างกาย \n6.ช่วยทำให้กระดูกเชื่อมติดกันเร็วขึ้น\n7.ช่วยรักษาปริมาณของเหลวในร่างกาย ช่วยรักษาอาการหูชั้นกลางอักเสบ \n8.ใช้รักษาโรคติดเชื้อและทางเดินหายใจ\n9.ประโยชน์ของผักคาวตองช่วยแก้ไข้ \n10.ช่วยรักษาโรคไข้มาลาเรีย ",
      "properties_eng":
          "1. has the effect of helping fight cancer inhibit the growth of cancer cells\n2. Has the effect of helping to treat high blood pressure\n3. Help strengthen the body's immunity to resist disease.\n4. Help extend the patient's life to fight the disease longer.\n5. It helps to stop diabetes. maintain body balance\n6. Helps make bones connect faster.\n7. Help maintain the amount of fluid in the body. Helps treat middle ear inflammation\n8. Used to treat infectious and respiratory diseases.\n9. benefits of kawtong vegetables to help cure fever\n10. Help cure malaria",
      "url_img": "assets/images/Plu Kaow.jpg",
      "url":
          "https:\/\/medthai.com\/%E0%B8%9E%E0%B8%A5%E0%B8%B9%E0%B8%84%E0%B8%B2%E0%B8%A7\/"
    },
    {
      "id": 47,
      "name_th": "ใบมะนาว",
      "name_eng": "Lime",
      "category": "Leaves",
      "properties_th":
          "1.ต้มน้ำดื่มเป็นยาแก้ไอ \n2.กัดฟอกหรือละลายเสมหะ \n3.แก้ท้องอืด ท้องเสีย ช่วยขับลม \n4.ช่วยเจริญอาหาร \n5.ฟอกโลหิตระดูหรือประจำเดือน",
      "properties_eng":
          "1. Boil drinking water as a cough syrup.\n2. Bleaching or dissolving phlegm\n3. Solve flatulence, diarrhea, help expel wind.\n4. Help appetite.\n5. Blood purification period or menstruation",
      "url_img": "assets/images/Lime.jpg",
      "url":
          "https:\/\/medthai.com\/%E0%B8%A1%E0%B8%B0%E0%B8%99%E0%B8%B2%E0%B8%A7\/"
    },
    {
      "id": 48,
      "name_th": "กะเพรา",
      "name_eng": "Holy basil",
      "category": "Leaves",
      "properties_th":
          "1.ช่วยทำให้ร่างกายอบอุ่นและป้องกันอาการหวัดได้ \nกะเพราเป็นส่วนประกอบของยาสมุนไพรหลายชนิด เช่น ยารักษาตานขโมยสำหรับเด็ก ยาแก้ทางเด็ก ฯลฯ รากแห้งนำมาชงหรือต้มกับน้ำร้อนดื่ม \n2.ช่วยแก้โรคธาตุพิการ\n3.ช่วยบำรุงธาตุไฟ \n4.ช่วยแก้อาการคลื่นเหียนอาเจียน \n5.ช่วยรักษาแผลในกระเพาะอาหาร\n6.ช่วยขับลมแก้อาการปวดท้องอุจจาระ\n7.ใบกะเพรามีสรรพคุณช่วยขับลมในกระเพา\n8.ช่วยแก้อาการจุกเสียดแน่นท้อง\n9.ช่วยแก้ลมซานตาง\n10.ใช้เป็นยารักษาหูด ด้วยการใช้ใบกะเพราแดงสดนำมาขยี้แล้วทาบริเวณที่เป็นหูดเช้า-เย็น จนกว่าหัวหูดจะหลุดออกมา โดยระวังอย่าให้เข้าตาและถูกบริเวณผิวที่ไม่ได้เป็นหูด เพราะจะทำให้เนื้อดีเน่าเปื่อยและรักษาได้ยาก",
      "properties_eng":
          "1. It can help warm the body and prevent cold symptoms.\nHoly basil is a component of many herbal medicines such as anti-theft medicines for children, children's medicines, etc. The dried roots are brewed or boiled with hot water to drink.\n2. Help solve disabilities.\n3. Help nourish the fire element.\n4. Helps to cure nausea and vomiting.\n5. Helps heal stomach ulcers.\n6. Help drive the wind to relieve stomach pain, stool.\n7. Basil leaves have properties that help expel the wind in the stomach.\n8. Helps to relieve colic, full of stomach.\n9. Help solve the Santa wind.\n10. Used as a cure for warts. By using fresh red basil leaves to crush and apply to the wart area in the morning-evening until the wart head comes off Be careful not to get it in your eyes and on areas of skin that are not warts. because it will cause the good flesh to rot and be difficult to maintain",
      "url_img": "assets/images/Holy basil.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%81%e0%b8%b0%e0%b9%80%e0%b8%9e%e0%b8%a3%e0%b8%b2\/"
    },
    {
      "id": 49,
      "name_th": "ย่านาง",
      "name_eng": "Yanang",
      "category": "Leaves",
      "properties_th":
          "1.ช่วยแก้อาการเจ็บปลายลิ้น\n2.ช่วยป้องกันและบำบัดรักษาโรคหัวใจ \n3.ช่วยป้องกันและรักษาโรคหอบหืด \n4.ช่วยรักษาโรคตับอักเสบ \n5.ช่วยรักษาอาการท้องเสีย เพราะช่วยฆ่าเชื้อโรคที่เป็นต้นเหตุได้ \n6.ช่วยบรรเทาอาการอาการปวดท้องเฉียบพลัน \n7.ช่วยแก้อาการท้องผูก ลดอาการแสบท้อง \n8.ช่วยรักษาโรคกระเพาะอาหาร ลำไส้อักเสบ \n9.ช่วยลดอาการหดเกร็งตามลำไส้ \n10.ช่วยรักษาอาการกรดไหลย้อน",
      "properties_eng":
          "1. Helps to relieve soreness at the tip of the tongue.\n2. Help prevent and treat heart disease.\n3. Help prevent and treat asthma.\n4. Help cure hepatitis.\n5. Helps treat diarrhea. because it can help kill the germs that cause it\n6. Help relieve acute abdominal pain.\n7. Helps to cure constipation. Reduce burning sensation\n8. Helps treat gastrointestinal diseases, inflammatory bowel disease.\n9. Help reduce symptoms of intestinal spasms.\n10. Helps cure acid reflux.",
      "url_img": "assets/images/Yanang.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b9%83%e0%b8%9a%e0%b8%a2%e0%b9%88%e0%b8%b2%e0%b8%99%e0%b8%b2%e0%b8%87\/"
    },
    {
      "id": 50,
      "name_th": "มะกรูด",
      "name_eng": "Leech lime",
      "category": "Leaves",
      "properties_th":
          "1.แก้ไอ \n2.แก้อาเจียนเป็นโลหิต \n3.แก้ช้ำใน \n4.กัดเสมหะในคอ \n5.แก้น้ำลายเหนียว \n6.กัดเถาดานในท้อง \n7.แก้ระดูเสียฟอกโลหิตระดู \n8.ขับลมในลำไส้ \n9.แก้จุกเสียด",
      "properties_eng":
          "1. Cough\n2. Cure bloody vomiting\n3. Fix bruises\n4. Bite phlegm in the throat\n5. Solve sticky saliva\n6. Bite the vine in the stomach\n7. Fix broken bones, purify menstrual blood\n8. expelling wind in the intestines\n9. Solve colic",
      "url_img": "assets/images/Leech lime.jpg",
      "url":
          "https:\/\/medthai.com\/%e0%b8%a1%e0%b8%b0%e0%b8%81%e0%b8%a3%e0%b8%b9%e0%b8%94\/"
    }
  ];

  String serchObject(String name) {
    final res = object_test.firstWhere((object) => object['name_th'] == name);
    if (res == -1) {
      return "not found";
    }
    launchURL(res['url'].toString());

    return res['url'].toString();
  }

  String serchImage(String name) {
    final res = object_test.firstWhere((object) => object['name_th'] == name);
    if (res == -1) {
      return "not found";
    }
    // launchURL(res['url'].toString());

    return res['url_img'].toString();
  }

  List predicted = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PredictpageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  predictClass() async {
    predicted = [];
    final interpreter =
        await Interpreter.fromAsset('tflite/best_model_i_ever_trained.tflite');
    print(interpreter.getInputTensors());
    print(interpreter.getOutputTensors());
    img.Image img_file =
        img.decodeImage(File(uploadedImage).readAsBytesSync())!;
    var image = img.copyResize(img_file, width: 224, height: 224);
    var img_rgb = image.getBytes(order: img.ChannelOrder.rgb);
    print((img_rgb.length / 3) / 224);
    print(img_rgb.toString());
    var output = List.filled(1 * 50, 0).reshape([1, 50]);
    var output_score = [];
    interpreter.run(img_rgb, output);
    for (var i = 0; i < output[0].length; i++) {
      output_score.add({
        'class': labels_TH[i],
        'score': ((output[0][i] / 255) * 100).round()
      });
    }

    output_score.sort((a, b) => a['score'].compareTo(b['score']));
    print(output_score[output_score.length - 1].toString());
    print(output_score[output_score.length - 2].toString());
    print(output_score[output_score.length - 3].toString());

    if (int.parse(output_score[output_score.length - 1]['score'].toString()) >
        30) {
      setState(() {
        predicted.add(output_score[output_score.length - 1]);
        predicted.add(output_score[output_score.length - 2]);
        predicted.add(output_score[output_score.length - 3]);
      });
    } else {
      setState(() {
        predicted.add(output_score[output_score.length - 1]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String imagePath = await actions.uploadImage(context);
            if (imagePath != 'exit') {
              predictClass();
              setState(() {
                uploadedImage = imagePath;
              });
            }
            return;
          },
          backgroundColor: Color(0xFF1C6758),
          elevation: 10.0,
          child: Icon(
            Icons.photo_camera,
            color: FlutterFlowTheme.of(context).gray200,
            size: 24.0,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
            child: Text(
              'Prediction',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Roboto',
                    color: Color(0xFF0F1113),
                    fontSize: 32,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Color(0x28000000),
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 12.0, 12.0, 12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 250.0,
                              child: Stack(
                                children: [
                                  uploadedImage != ""
                                      ? Hero(
                                          tag: uploadedImage,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.file(
                                              File(uploadedImage),
                                              width: double.infinity,
                                              height: 250.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Hero(
                                          tag: uploadedImage,
                                          child: Text("Select Image")),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 0.0, 12.0),
                      child: Text(
                        'Result (Top-3 Similarity)',
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Roboto',
                                  color: Color(0xFF0F1113),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: List.generate(predicted.length, (i) {
                                print(
                                    "output : " + predicted.length.toString());
                                if (predicted.length > 1) {
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 8.0),
                                    child: InkWell(
                                      onTap: () => {
                                        print("test fuction : " +
                                            serchObject(predicted[i]['class']))
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 3.0,
                                              color: Color(0x411D2429),
                                              offset: Offset(0.0, 1.0),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 8.0, 8.0, 8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 1, 1, 1),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  child: Image.asset(
                                                    serchImage(predicted[i]
                                                            ['class'])
                                                        .toString(),
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 8.0, 4.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        predicted[i]['class'],
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .headlineSmall
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              color: Color(
                                                                  0xFF0F1113),
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    8.0,
                                                                    0.0),
                                                        child: AutoSizeText(
                                                          predicted[i]['score']
                                                                  .toString() +
                                                              "%",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: Color(
                                                                    0xFF57636C),
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 4.0,
                                                                0.0, 0.0),
                                                    child: Icon(
                                                      Icons
                                                          .chevron_right_rounded,
                                                      color: Color(0xFF57636C),
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 8.0),
                                    child: InkWell(
                                      onTap: () => {
                                        // print("test fuction : " +
                                        //     serchObject(predicted[i]['class']))
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 3.0,
                                              color: Color(0x411D2429),
                                              offset: Offset(0.0, 1.0),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 8.0, 8.0, 8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 1, 1, 1),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  child: Image.asset(
                                                    'assets/images/Gallery.jpg',
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 8.0, 4.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'ไม่พบสมุนไพรใกล้เคียง',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .headlineSmall
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              color: Color(
                                                                  0xFF0F1113),
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    8.0,
                                                                    0.0),
                                                        child: AutoSizeText(
                                                          "กรุณาลองใหม่อีกครั้ง",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: Color(
                                                                    0xFF57636C),
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 4.0,
                                                                0.0, 0.0),
                                                    // child: Icon(
                                                    //   Icons
                                                    //       .chevron_right_rounded,
                                                    //   color: Color(0xFF57636C),
                                                    //   size: 24.0,
                                                    // ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
