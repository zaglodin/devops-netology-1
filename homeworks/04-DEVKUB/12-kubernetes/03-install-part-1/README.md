# Homework 12.3

## Задание 1: Описать требования к кластеру

- Три копии базы потребляют 12 ГБ ОЗУ. Допустим, по 2 ядра на каждую копию - это 6. Про размер базы ничего неизвестно, но допустим, что для начала хватит 100ГБ на копию, а потом можно будет добавить, при необходимости.
- Допустим, что более трех копий это 5. 20 ГБ ОЗУ и 5 ядер. Здесь ведь копии не реплики, как в случае с базой?
- 250 МБ ОЗУ и 5 ядер на 5 копий.
- 6 ГБ ОЗУ и 10 ядер на 10 копий.

Всего 26 ядер, 38250 ОЗУ

Полагаю, что реплики должны находиться на разных нодах, иначе какой смысл репликации - умрет одна нода и всё, нет базы. Так что минимум 3 ноды.

Всего выходит 3 ноды, по 12 ядер и 13 ГБ ОЗУ. Также надо добавить каждой по 2ГБ и 2 ядра на работу системы и Control plane (если одна нода выйдет из строя, то Control plane переедет на другую, если я правильно понял).

Получается 3 ноды по 14 ядер, 15 ГБ ОЗУ и каким-нибудь диском, достаточным для всего этого (ну, например 200ГБ). Правда при смерти одной ноды, нужно куда-то распределить нагрузку в 12 ядер и 13 ГБ. Поэтому нужно разделить их на два и добавить столько каждой ноде. Либо просто добавить ещё одну ноду - это точно менее затратно по ресурсам, но непонятно, дешевле ли. Если это физические сервера, то скорее дороже. А если в облаке, то надо смотреть по ситуации. Ну и опять же, если это физические сервера, то у нас может не быть возможности добавлять точное число ядер и ОЗУ, которое мы хотим.

Вобщем, нюансов много и я уже окончательно запутался, но в целом, по-моему, должен сработать вариант с 4 нодами по 14 ядер и 15 ГБ ОЗУ. Таким образом ресурсов хватит на все приложения, работу ОС, Control plane, а также всё это останется стабильным и не потеряет в производительности при выходе из строя одной ноды.

Честно говоря, вообще не понял смысл этого задания. Оно не имеет никакого отношения к лекции. У меня нет опыта в таком проектировании и на лекциях этого не было. Ответ полностью состоит из предположений и моих догадок о том, как это теоретически может быть в реальности. Мне кажется, что относительно адекватный ответ на такое задание может дать только человек, уже имевший опыт проектирования кластера, но и он бы, наверное, задал кучу уточняющих вопросов, прежде выдать какую-либо оценку.
