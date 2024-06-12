import 'package:flutter/material.dart';

import 'loginpage.dart';

class AdvisePage extends StatelessWidget {
  const AdvisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text((selectedLanguage == 'ru') ? 'Финансовые советы' :
        (selectedLanguage == 'kz') ? 'Қаржылық ақыл кеңес' : 'Financial advice',),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SingleChildScrollView(child: Text( (selectedLanguage == 'ru') ? """КАК САМОСТОЯТЕЛЬНО НАУЧИТЬСЯ ФИНАНСОВОЙ ГРАМОТНОСТИ
        1.	Начните вести учет доходов и расходов. Как именно будете это делать, в приложении на телефоне или записывать в блокнот — не важно. Главное, что вы должны точно знать: сколько денег приходит каждый месяц, сколько вы тратите и сколько остается. Естественно, если что-то остается.
        2.	Отслеживайте скрытые платежи. Это подписки, плата за использование мобильных приложений, навязанные банком услуги и т.д. Они может и небольшие, но регулярно вытягивают деньги из вашего бюджета.
        3.	Планируйте покупки. В первую очередь, стоит отказаться от спонтанных приобретений: “Увидел-Загорелся-Купил”. Это неправильно, потому что большинство из этого вам просто не нужно, а потраченных денег уже не вернете.
        4.	Начинайте откладывать. Обычно советуют откладывать 10% дохода и класть эти средства на депозит и фондовый рынок. Это, конечно, правильно — если есть что откладывать... 
        А если вы в минусе? И откладывать нечего? Что делать тогда?
        Для начала, будем реалистами: если откладываете по 1-2 тысячи рублей в месяц, это никак не поможет поправить ваше финансовое положение. Итоговая сумма все равно будет небольшая и ее постоянно съедает инфляция. Да и вообще довольно грустно жить, если экономить каждый рубль и выбирать только красные ценники в магазинах…
        5.  Планируйте ваши доходы:
        •	Определите сколько денег вам нужно
        •	Как и на чем вы их можете заработать
        •	Постепенно повышайте стоимость вашего часа. Потому что у вас не появится 5 дополнительных часов в сутки, чтобы увеличивать заработок по схеме “Больше работай — больше получай”
        О том, как встроить эти привычки в вашу жизнь — смотрите в видео Юлии Трус “Почему бедные беднеют, а богатые богатеют?”
        https://www.youtube.com/watch?v=hEQZRyEdi28&list=PLFxpgY-pWJ6H7tbuCVVei5FxCwZmAD3B0  
        """ : (selectedLanguage == 'kz') ? """ҚАРЖЫЛЫҚ САУАТТЫЛЫҚТЫ ӨЗ БЕТІҢІЗШЕ ҚАЛАЙ ҮЙРЕНУГЕ БОЛАДЫ
        
        1.	Кірістер мен шығыстардың есебін жүргізуді бастаңыз. Мұны қалай жасайсыз, телефондағы қосымшада немесе ноутбукке жазу маңызды емес. Ең бастысы, сіз нақты білуіңіз керек: ай сайын қанша ақша келеді, қанша жұмсайсыз және қанша қалады. Әрине, егер бірдеңе қалса.
        2.	Жасырын төлемдерді қадағалаңыз. Бұл жазылымдар, Мобильді қосымшаларды пайдалану ақысы, банк жүктеген қызметтер және т.б. олар аз болуы мүмкін, бірақ сіздің бюджетіңізден үнемі ақша алады.
        3.	Сатып алуды жоспарлаңыз. Ең алдымен, стихиялық сатып алулардан бас тартқан жөн: "көрдім-Өртендім-сатып алдым". Бұл дұрыс емес, өйткені оның көпшілігі сізге қажет емес, ал жұмсалған ақша енді қайтарылмайды.
        4.	Кейінге қалдыруды бастаңыз. Әдетте кірістің 10% -. үнемдеуге және осы қаражатты депозит пен қор нарығына салуға кеңес беріледі. Бұл, әрине, дұрыс-егер кейінге қалдыратын нәрсе болса... 
        
        Ал егер сіз минус болсаңыз? Ал кейінге қалдыратын ештеңе жоқ па? Сонда не істеу керек?
        Жаңадан бастаушылар үшін біз шынайы боламыз: егер сіз айына 1-2 мың рубль бөлсеңіз, бұл сіздің қаржылық жағдайыңызды түзетуге көмектеспейді. Қорытынды сома әлі де аз болады және оны инфляция үнемі жейді. Жалпы алғанда, егер сіз әр рубльді үнемдесеңіз және дүкендерде тек қызыл баға белгілерін таңдасаңыз, өмір сүру өте өкінішті…
        
        5.  Табысыңызды жоспарлаңыз:
        
        1.	Сізге қанша ақша қажет екенін анықтаңыз
        2.	Оларды қалай және не арқылы табуға болады
        3.	Сағаттың құнын біртіндеп арттырыңыз. Өйткені сізде "көбірек жұмыс істеу-көбірек алу" схемасы бойынша кірісті арттыру үшін күніне 5 қосымша сағат болмайды
        
        Бұл әдеттерді сіздің өміріңізге қалай енгізу керектігі туралы-Джулия қорқақтың бейнесін қараңыз "Неліктен кедейлер кедей, ал байлар бай?”
        https://www.youtube.com/watch?v=hEQZRyEdi28&list=PLFxpgY-pWJ6H7tbuCVVei5FxCwZmAD3B0 """ : """HOW TO LEARN FINANCIAL LITERACY ON YOUR OWN
        1.	Start keeping records of income and expenses. How exactly you will do it, in the app on your phone or write it down in a notebook — it does not matter. The main thing is that you need to know exactly how much money comes in every month, how much you spend and how much remains. Naturally, if something remains.
        2.	Track hidden payments. These are subscriptions, fees for using mobile applications, services imposed by the bank, etc. They may be small, but they regularly pull money out of your budget.
        3.	Plan your purchases. First of all, it is worth giving up spontaneous purchases: “I saw-I caught fire-I Bought.” This is wrong, because you just don't need most of it, and you won't get back the money you spent.
        4.	Start procrastinating. It is usually advised to save 10% of income and put these funds on deposit and the stock market. This is, of course, the right thing to do — if there is something to postpone... 
        And if you are in the red? And there's nothing to put off? What should I do then?
        To begin with, let's be realistic: if you save 1-2 thousand rubles a month, it will not help to improve your financial situation in any way. The total amount will still be small and it is constantly being eaten up by inflation. And in general, it's pretty sad to live if you save every ruble and choose only red price tags in stores…
        5. Plan your income:
        1.	Determine how much money you need
        2.	How and on what can you earn them
        3.	Gradually increase the cost of your hour. Because you will not have 5 additional hours a day to increase earnings according to the scheme “Work more, get more”
        How to embed these habits into your life — watch Julia Coward's video “Why do the poor get poorer and the rich get richer?”
        https://www.youtube.com/watch?v=hEQZRyEdi28&list=PLFxpgY-pWJ6H7tbuCVVei5FxCwZmAD3B0  
        """, style: TextStyle(fontSize: 15),),),
      ) );
  }
}
