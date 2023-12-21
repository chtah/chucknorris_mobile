import 'package:chucknorris/widgets/qa_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({
    super.key,
  });

  @override
  State<QuestionAnswer> createState() {
    return _QuestionAnswer();
  }
}

class _QuestionAnswer extends State<QuestionAnswer>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final backgroundColor = ColorTween(
          begin: const Color.fromARGB(150, 241, 90, 34),
          end: const Color.fromARGB(148, 198, 198, 54),
        ).evaluate(controller);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                backgroundColor!,
                const Color.fromARGB(150, 235, 135, 98)
              ],
            ),
          ),
          child: ListView(
            children: const [
              SizedBox(
                height: 10,
              ),
              QACard(
                  question:
                      'Q : ระหว่าง SingleChildScrollView กับ ListView เลือกใช้อะไร และทำไม ?',
                  answer:
                      '1.ListView ใช้สำหรับต้องการให้ widget หลายๆ widget สามารถ scroll เรียงกันลงมา และเราสามารถ scroll เพื่อดูหลายๆ widget ได้ ,ส่วน SingleChildScrollView จะใช้เมื่อเป็น widget เดียว แต่มีความยาวมาก ต้องการ scroll เพื่อดู widget นั้นให้ครบ\n2.ListView จะ render เฉพาะ widget ที่โชวอยู่บนหน้าจอ เมื่อเลื่อนผ่านไปหรือยังเลื่อนไม่ถึงก็จะไม่ render ,ส่วน SingleChildScrollView จะ render widget ทั้งหมด ส่งผลให้กิน memory มากกว่าได้\n3.ListView ปรับแต่งได้น้อยกว่า เช่น width ของ widget จะเท่าๆกัน ,ส่วน SingleChildScrollView จะปรับแต่งได้มากกว่า เช่นอยากให้แต่ละ widget width เท่าไหร่ก็เลือกปรับได้เลย'),
              QACard(
                  question: 'Q : Dart 3.0 มีอะไรอัพเดทใหม่ ?',
                  answer:
                      '1.100% sound null safety คือ มีระบบคอยตรวจเช็คโค้ดว่าค่า Null ได้รับการจัดการอย่างถูกต้องและป้องกันการเกิด Error เมื่อ pointer ชี้ไปที่ค่า Null\n2.records ช่วยลดความซับซ้อนของโค้ดและรองรับได้หลาย type ใน 1 records\n3.patterns ช่วยลดการเขียนโค้ดโดยจะ match type ให้โดยอัตโนมัติ โดยไม่ต้องประกาศ type และยังช่วยป้องกันไม่ให้ใช้ format ผิดประเภทตัวแปร\n4.ปรับปรุง switch and if ให้ดีขึ้น สามารถ match type ใน switch และใน if ,else if, else สามารถใช้ตัวย่อได้\n5.List Extensions มีคำสั่ง .toList() เพื่อสร้าง List ได้เลยโดยไม่ต้องประกาศ เป็น List ก่อน'),
              QACard(
                  question: 'Q : ข้อดี ข้อเสีย ของ Flutter ?',
                  answer:
                      'ข้อดี\n1.มี Hot reload สามารถแสดงผลการเปลี่ยนแปลงเมื่อเปลี่ยนโค้ดได้เลยในทันที ทำให้พัฒนาแอปได้เร็ว\n2.Single codebase เขียนโค้ดครั้งเดียวรองรับได้ทั้ง Android และ IOS ช่วยประหยัดเวลากว่าการเขียนโค้ดแยก Platform\n3.มี Widget ที่สวยงามให้เลือกใช้งานมากมาย\n4.High performance\n5.Open-source มี document ให้อ่านและมีการอัพเดทตลอดเวลา\nข้อเสีย\n1.มีผู้ใช้งานน้อย ทำให้เวลาหาข้อมูลเมื่อเกิดปัญหา หาข้อมูลได้ยาก\n2.จำนวน 3rd party library น้อย\n3.ขนาดของ App ใหญ่กว่า Native App\n4.การ Debugging ซับซ้อนกว่า Native app'),
              QACard(
                  question: 'Q : Classes ต่างกันอย่างไร ?',
                  answer:
                      'Classes ใน Dart คือแบบแปลนสำหรับสร้าง object ซึ่งจะคอยระบุว่า object นั้นจะมี property และ คุณลักษณะเป็นแบบไหน , สามารถสร้าง classes stateless และ stateful ได้โดย stateless คือ classes ที่ไม่สามารถเปลี่ยนแปลงได้ส่วน stateful สามารถเปลี่ยนแปลงได้\nClasses ใน Flutter หมายถึง widget เราสามารถสร้าง widget โดยใช้ classes, มี StatelessWidget สำหรับ static content และ StatefulWidget สำหรับ dynamic content\n\n1.Concrete Classes vs Abstract Classes\nConcrete Classes ใช้สร้าง object โดยตรง ส่วน Abstract Classes จะเป็นแบบแปลนสำรับ extend ไปสร้าง Concrete Classes อีกทีนึง โดยสามารถใช้ Abstract Classes สร้างหลายๆ Concrete Classes ได้\n\n2.Final vs. Open Classes\nFinal Classes ไม่สามารถนำไปใช้หรือ extend โดย classes อื่นได้ สว่น Open Classes สามารถถูกนำไปใช้โดย classes อื่นได้\n\n3.Regular vs. Utility Classes\nRegular classes เป็น classes ทั่วไปแสดง object และ state ส่วน Utility Classes ใช้เป็นฟังก์ชั่นเบ็ดเตล็ดและส่วนใหญ่เป็นแบบ static เช่นฟังก์ชั่นการคำนวนทางคณิตศาสตร์ต่างๆ จัดเป็น Utility Classes'),
              QACard(
                  question: 'Q : Abstract ?',
                  answer:
                      'Abstract Classes เป็น classes เชิงนามธรรม เป็นแบบแปลนสำหรับการสร้าง Classes อีกทีนึง'),
              QACard(
                  question: 'Q : Base ?',
                  answer:
                      'ใช้ระบุว่า classes ย่อยนั้นมีความสัมพันธ์กับ base classes parent โดยใช้ extends เพื่อใช้ function ของ base classes parent ได้'),
              QACard(
                  question: 'Q : Final ?',
                  answer:
                      '1.Final Classes คือ classes ที่ไม่สามารถแก้ไขหรือสืบทอดได้โดย classes ไหนเลย\n2.Final Member คือตัวแปรที่ไม่สามารถแก้ไขในภายหลังได้'),
              QACard(
                  question: 'Q : Interface ?',
                  answer:
                      'Interface คือแบบแปลนหรือสัญญาสำหรับ class ว่า class นั้นจะมีข้อมูลอะไรบ้าง ทำอะไรได้บ้าง โดย interface จะไม่ระบุค่าของข้อมูลเป็นแค่ไกด์ไลน์เท่านั้น'),
              QACard(
                  question: 'Q : Sealed ?',
                  answer:
                      'Sealed Classes คือ classes ที่มีความปลอดภัยสูง อนุญาติให้เฉพาะ subclasses ของตัวเองเข้าถึงได้เท่านั้น classes อื่นๆ ไม่สามารถสืบทอดหรือเข้าถึงได้'),
              QACard(
                  question: 'Q : Mixin ?',
                  answer:
                      'mixin คือการเพิ่มความสามารถให้ classes โดยไม่ต้องสืบทอดจาก classes โดยตรง ทำให้ classes นั้นสามารถใช้ function ของ mixin นั้นๆได้ โดย mixin สามารถไปอยู่ได้ในหลายๆ classes'),
            ],
          ),
        );
      },
    );
  }
}
