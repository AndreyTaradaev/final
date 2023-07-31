--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9
-- Dumped by pg_dump version 14.2

-- Started on 2023-07-31 18:00:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET escape_string_warning = off;
SET row_security = off;

DROP DATABASE gonews;
--
-- TOC entry 2183 (class 1262 OID 332256437)
-- Name: gonews; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE gonews WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'ru_RU.UTF-8' TABLESPACE = archive;


\connect gonews

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET escape_string_warning = off;
SET row_security = off;

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

--
-- TOC entry 197 (class 1259 OID 332258818)
-- Name: NewsRss; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."NewsRss" (
    id bigint NOT NULL,
    title character varying NOT NULL,
    description character varying,
    "time" bigint NOT NULL,
    url character varying NOT NULL,
    hashrss bigint NOT NULL
);


--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss".id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public."NewsRss".id IS 'id rss';


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss".title; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public."NewsRss".title IS 'title rss';


--
-- TOC entry 2187 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss".description; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public."NewsRss".description IS 'тело новости';


--
-- TOC entry 2188 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss"."time"; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public."NewsRss"."time" IS 'время новости';


--
-- TOC entry 2189 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss".url; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public."NewsRss".url IS 'ссылка  на новость';


--
-- TOC entry 2190 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss".hashrss; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public."NewsRss".hashrss IS 'crc64 расчитывается по ИД новости для того чтобы исключить дублирование загрузки одинаковых новостей';


--
-- TOC entry 196 (class 1259 OID 332258816)
-- Name: NewsRss_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."NewsRss_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2191 (class 0 OID 0)
-- Dependencies: 196
-- Name: NewsRss_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."NewsRss_id_seq" OWNED BY public."NewsRss".id;


--
-- TOC entry 2051 (class 2604 OID 332258821)
-- Name: NewsRss id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NewsRss" ALTER COLUMN id SET DEFAULT nextval('public."NewsRss_id_seq"'::regclass);


--
-- TOC entry 2177 (class 0 OID 332258818)
-- Dependencies: 197
-- Data for Name: NewsRss; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."NewsRss" VALUES (65040, '[recovery mode] Как делается OpenSource: личный опыт', 'Я - автор двух пакетов, входящих более-менее во все дистрибутивы Linux: sane-airscan и ipp-usb.Кроме того, sane-airscan входит во все основные дистрибутивы BSD (FreeBSD, NetBSD и OpenBSD) и в ChromeOS. ipp-usb в ChromeOS не взяли потому, что он написан на Go, а у них там очень жестко с размером исполняемых файлов, вместо этого они написали свое на Rust, но предпочли бы взять моё изделие, если бы могли. Совсем недавно появился порт ipp-usb на FreeBSD, вероятно, другие BSD тоже скоро подтянутся.Вместе эти два пакета образуют стек "бездрайверного" сканирования документов для Linux и *BSD, а в перспективе нескольких лет, когда старые сканеры, наконец, вымрут, вероятно других драйверов и не останется.Кроме того, ipp-usb делает возможным "бездрайверную" печать на USB-устройствах.Здесь я хочу рассказать, каково оно, быть автором популярных OpenSource пакетов. Хоть эта работа и не принесла мне особых денег (на что я, впрочем, особо и не рассчитывал), она принесла мне бесценный опыт.В целом, я полагаю, продвижение OpenSource пакетов структурно близко к продвижению на рынок программных продуктов. Занимаясь этой деятельностью, очень хорошо начинаешь понимать разницу между (1) написать программу, которая работает для меня (2) написать программу, которую можно назвать продуктом (3) вывести продукт на рынок. Первое занимает гораздо меньше времени, чем второе. Второе - гораздо меньше времени, чем третье. Читать далее', 1690623921, 'https://habr.com/ru/articles/751214/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751214', -1039894873402540124);
INSERT INTO public."NewsRss" VALUES (65041, 'Почему вам не нужно в IT', 'Хочешь войти в айти? А насколько оно  надо? История вайтишника,  взятая не с отзыва на обучающем сайте.Краткое резюме о заблуждениях, которые были развеяны в процессе настоящей работы. Читать далее', 1690616412, 'https://habr.com/ru/articles/751186/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751186', -1039520977977376860);
INSERT INTO public."NewsRss" VALUES (65042, 'Владивосток: далёкий, праворульный, но всё равно «нашенский»', '
Потрясающий город. Живой и зелёный. Сопки, острова и море вокруг просто ласкают взгляд, уставший от плоскости средней полосы. Гордо взмывают ввысь вантовые мосты. Чувствуется дыхание Азии. Совсем не таким я представлял наш рубежный город на Тихом океане и конец Транссиба. Но рельеф города, придающий ему столь неповторимый вид, и место расположения накладывают очень большие ограничения на градостроительную деятельность, развитие транспорта и систему водоснабжения. Во многом именно с ним связано превращение Владивостока в автомобильную столицу, бытовые неурядицы 1990-х гг. и значимость проведения саммита АТЭС в 2012 г. Но обо всём по порядку. Читать дальше &rarr;', 1690624801, 'https://habr.com/ru/companies/ruvds/articles/751170/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751170', -674047259635315622);
INSERT INTO public."NewsRss" VALUES (65043, 'История компьютерных стратегий. Часть 6. «Red Alert»: «Киров» ещё не репортинг, но Сталин пьёт Vodka', '
Итак, «Warcraft: Orcs &amp; Humans» от Blizzard и «Command &amp; Conquer» от Westwood Studios непосредственно наследовали «Dune II». «C&amp;C» продолжал её почти напрямую, а авторы первого «Варкрафта» просто были очень впечатлены и решили сделать что-то в том же духе. Обе игры оказались удачными, обе легли в основу обширных серий и заложили первые камни в основание многолетней популярности жанра RTS. Естественно, что две конкурирующие студии не собирались почивать на лаврах и буквально сразу после релиза принялись развивать тему. Но если Blizzard напрямую продолжили свою историю борьбы людей и орков в фэнтезийном мире «Warcraft 2», то Westwood Studios решили сделать приквел к C&amp;C и представили версию Второй мировой войны без нацистской Германии. Так родился развесисто-клюквенный сеттинг «Red Alert». Читать дальше &rarr;', 1690639201, 'https://habr.com/ru/companies/ruvds/articles/750188/?utm_source=habrahabr&utm_medium=rss&utm_campaign=750188', -673072611320886182);
INSERT INTO public."NewsRss" VALUES (65044, 'Предшественники интернет-торговли', '

Вы даже представить себе не можете, какими словами крыла американская пресса новшество Аарона Монтгомери Уорда.

«Чикаго трибьюн», пожалуй, пошла дальше всех, разместив набранное крупным шрифтом: «Внимание! Не имейте дела с Монтгомери Уордом и его компанией. Они мошенники!» – а дальше разъяснялось, что цен, указанных в рекламных рассылках Уорда, не бывает в природе и делают такие рассылки жулики, цель которых – просто выманить у доверчивых покупателей деньги.

Чем ответил на это Уорд? Он придумал совершенно новый ход, вошедший в историю как «satisfaction guaranteed», смысл которого заключался в гарантиях продавца: или вас удовлетворила эта покупка, или Уорд готов принять свой товар назад и вернуть деньги — без объяснения причин отказа.

Эта норма прекрасно дожила до нашего времени. Сегодня она стала непреложным законом, благодаря которому приобретение товаров, которые мы не можем пощупать, попробовать или понюхать, в конце концов стало безопасно для покупателей и прибыльно для продавцов (сегодня это, конечно же, продажи через интернет). Читать дальше &rarr;', 1690617661, 'https://habr.com/ru/companies/timeweb/articles/751130/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751130', -314044270208509541);
INSERT INTO public."NewsRss" VALUES (65045, 'Как протестировать код на Go с базой данных?', 'Как протестировать код на Go с базой данных? В этой статье опишу пример такого тестирования в связке с Postgres, очисткой на основе копирования базы данных и рассмотрю некоторые альтернативы. Читать далее', 1690628067, 'https://habr.com/ru/articles/751220/?utm_campaign=751220&utm_source=habrahabr&utm_medium=rss', -1038273437348954204);
INSERT INTO public."NewsRss" VALUES (65047, 'Golang — архитектурный линтер', 'Для того чтобы повысить качество приложения, написанного на языке go, можно использовать разные линтеры. Один из таких линтеров&nbsp;— архитектурный.В данной статье расскажу про свой бесплатный, open-source, линтер под MIT лицензией и чем он может быть полезен. Читать далее', 1690607940, 'https://habr.com/ru/articles/751174/?utm_campaign=751174&utm_source=habrahabr&utm_medium=rss', -1039899691013668956);
INSERT INTO public."NewsRss" VALUES (65046, 'Как мы трёхколёсный велосипед изобретали', 'Не то что бы я пытался конкурировать с DIY-стратостатом, конечно. Если где-то в конкурсе есть космос или хотя бы стратосфера — они уже победили, причём заслуженно. Но, будучи прожжённым стервятником индустриальной экосистемы, последним теплокровным перед одноклеточными добытчиками ценных и не очень металлов, не поучаствовать в оргии был бы страшный грех.Началось всё в дветыщимохнатом году, когда мы с другом, насмотревшись видео про адски дикие и упоротые велоконструкции, перевозбудили случайно свою конструкторскую фантазию. Мысль выкристаллизовалась быстро и была на первый взгляд блестящей — за всё хорошее и против всего плохого, то есть дать конструкции те степени свободы, которые ей нужны, отобрать те, которые ей вредны и распределить вес между тремя колёсами равномерно. То есть так: Поехали по кочкам!', 1690620852, 'https://habr.com/ru/articles/751202/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751202', -1039156482625011804);
INSERT INTO public."NewsRss" VALUES (65049, 'Сравниваем скорость и оверхеды библиотек Deep Copy для Go', 'Егор Гартман, бэкендер Авито, рассказал, как протестировал несколько библиотек Deep Copy, а потом сделал свою — быстрее и эффективнее.  Читать далее', 1690444802, 'https://habr.com/ru/companies/avito/articles/743332/?utm_campaign=743332&utm_source=habrahabr&utm_medium=rss', -670412145566976310);
INSERT INTO public."NewsRss" VALUES (65051, 'Добавляем Starlark в приложение на Go', 'Starlark (ранее известный как Skylark) - питоноподобный язык, изначально разработанный для системы сборки Bazel, со временем выбравшийся за её пределы через интерпретаторы для Go и Rust.Язык располагает к использованию в роли инструмента конфигурации, однако, благодаря хорошо написанному интерпретатору на Go и описанию спецификации, его можно использовать в виде встроенного в приложение языка программирования - например, когда вы хотите дать пользователю повзаимодействовать с объектом логики приложения, но не хотите постоянно плодить сущности под почти одинаковые кейсы через сотню настроечных параметров (мой случай).Достаточно полных туториалов в процессе работы у меня найти не удалось, поэтому появилась идея написать небольшой материал по этой теме. В статье пройдемся по работе с Starlark в Go, от простейшего запуска скрипта до добавления нового встроенного типа. Читать далее', 1690190290, 'https://habr.com/ru/articles/749842/?utm_campaign=749842&utm_source=habrahabr&utm_medium=rss', -1039159015120646236);
INSERT INTO public."NewsRss" VALUES (65054, '[Перевод] Как начинать проект на Go в 2023 году', 'Когда-то я написал статью о том, как начинать проект на Go в 2018 году. С тех пор многое изменилось, и я захотел написать обновлённую версию статьи. В ней я расскажу всё, что нужно новичку, чтобы приступить к работе с Go. Читать далее', 1690185165, 'https://habr.com/ru/companies/mvideo/articles/744434/?utm_campaign=744434&utm_source=habrahabr&utm_medium=rss', -6771347227801654641);
INSERT INTO public."NewsRss" VALUES (65057, 'Как построить систему, способную выдерживать нагрузку в 5 млн rps', 'Всем привет!&nbsp;Меня зовут Владимир Олохтонов, я руковожу командой разработки в отделе Message Bus, который является частью платформы Ozon. Мы занимаемся разработкой самых разных систем вокруг Kafka, etcd и Vault. В этой статье я расскажу о том, как мы строили линейно масштабируемую gRPC-прокси перед Kafka, способную обслуживать миллионы запросов в секунду, используя Go. Читать далее', 1689855205, 'https://habr.com/ru/companies/ozontech/articles/749328/?utm_campaign=749328&utm_source=habrahabr&utm_medium=rss', -9140437245366369825);
INSERT INTO public."NewsRss" VALUES (65060, 'Go: особенности написания конкурентных программ', 'Всем нам предстоит поддерживать уже существующий код, а также проводить ревью кода коллег.Иногда становится очень тяжело видеть некоторые паттерны, которые кажутся безобидными, но при некорректном использовании или после неосторожного рефакторинга могут привести к различным проблемам: утечке горутин и каналов, повреждению целостности структур данных, паникам, трудноуловимым багам в бизнес-логике, самому страшному - неутолимому желанию порефакторить код, который выглядит как то, что вы бы написали в первый день работы с Go.В своей статье я хочу дать рекомендации, которые, по моему мнению, могут помочь избежать перечисленных выше проблем. Читать далее', 1689760485, 'https://habr.com/ru/articles/744038/?utm_campaign=744038&utm_source=habrahabr&utm_medium=rss', -1037289731439276124);
INSERT INTO public."NewsRss" VALUES (65063, 'Криптография на Rust и немного FFI', 'Расскажу как создать Bitcoin кошелек используя только криптографические функции и о своем опыте разработки FFI (меж-языковой) библиотеки для Go. Читать', 1689601381, 'https://habr.com/ru/articles/748534/?utm_campaign=748534&utm_source=habrahabr&utm_medium=rss', -1039893378551591004);
INSERT INTO public."NewsRss" VALUES (65230, ' #468885', '#вкусныйтортВремён увлечения кулинарными экпериментами: сначала в ящике со столовыми приборами появляются пинцеты и шприцы, а потом &quot;милый, сегодня ужина не будет, у нас закончился жидкий азот&quot;.', 1645677906, 'http://bashorg.org/2022/02/24/468885.html', 5986381409087241736);
INSERT INTO public."NewsRss" VALUES (65048, 'Быть или не быть тимлидом – вот в чём вопрос', 'Есть стереотип, что по достижении определенного скила нужно продвигаться в тимлиды. Я тоже поверил в него: поделюсь историей, как попробовал управлять командой и какие выводы сделал о развитии своей карьеры.Те, кто собираются в тимлиды, поймут, какие подводные камни могут ждать. Тех, кто уже у руля, приглашаю к дискуссии в комментарии. Ну, а HR смогут взглянуть со стороны на сотрудника и его ощущения. Читать далее', 1690617721, 'https://habr.com/ru/companies/alfa/articles/750844/?utm_source=habrahabr&utm_medium=rss&utm_campaign=750844', -6457656924665334304);
INSERT INTO public."NewsRss" VALUES (65050, 'Борьба за ресурсы Китая и США: галлий и германий дорожают. Перспективы рынка редкоземельных металлов', '

Мы уже писали о том, что с 1 августа Китай планирует ограничить экспорт галлия и германия. Оба элемента используются в производстве электроники для самых разных отраслей. Скорее всего, это лишь первый шаг, после чего Китай начнет предпринимать схожие шаги и в отношении других ресурсов. Но меры еще не вступили в силу, а вот цены уже растут. О том, что может произойти в ближайшем будущем с рынком галлия, германия и других редкоземельных металлов — под катом.  Читать дальше &rarr;', 1690635327, 'https://habr.com/ru/companies/selectel/articles/713100/?utm_source=habrahabr&utm_medium=rss&utm_campaign=713100', 1009530503182456244);
INSERT INTO public."NewsRss" VALUES (65053, 'В Днепропетровской области ночью произошел пожар', '
    Пожар произошел ночью в Днепропетровской области, сообщил глава областной администрации Сергей Лысак. Как уточнил Лысак, к настоящему моменту возгорание ликвидировано. В ночь с субботы на воскресенье, с 29 на 30 июля, в Днепропетровской области была объявлена воздушная тревога. Она длилась 1 час 20 минут. 
  ', 1690694029, 'https://lenta.ru/news/2023/07/30/ogon_/', -6657083324616933130);
INSERT INTO public."NewsRss" VALUES (65055, 'IntelliJ IDEA 2023.2. Language Server Protocol, AI Assistant, IntelliJ Profiler в редакторе, GitLab merge requests, ftw', 'Только что вышла IntelliJ IDEA 2023.2. В этом релизе в IDE появилась куча интересных фичей и важных улучшений.Вы можете скачать последнюю сборку с&nbsp;официального сайта, или из бесплатного приложения&nbsp;Toolbox, или из snap-пакетов для Ubuntu.Этот релиз IntelliJ IDEA 2023.2 представляет вам AI-ассистента, вооруженного набором инструментов машинного обучения. IntelliJ Profiler показывает подсказки в редакторе, делая профилирование более интуитивным и иформативным. Еще, в этом релизе появилась интеграция с GitLab.В том посте мы пробежимся по всем основным фичам IntelliJ IDEA 2023.2. В отличие от официального анонса, вся европейская политкорректность выкинута на свалку, автор перевода не видит никакой ценности в соблюдении повесточки.Кроме того, в этот четверг в Питере будет встреча Javawatch, посвященная Java 21. Я прочитаю мини-доклад минут на 30 о новых фичах, и потом мы сможем все вместе собраться и за кружкой пива это обсудить. Анонс события&nbsp;в телеге, обсуждение&nbsp;в чате. Я бывший PMM в JetBrains Big Data и тимлид в Remote Development/Projector, а сейчас работаю над российским дистрибутивом Java - Axiom JDK. Волшебно. Читать далее.', 1690642497, 'https://habr.com/ru/companies/bar/articles/751248/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751248', -8488329081236480115);
INSERT INTO public."NewsRss" VALUES (65056, 'Российский военный заявил об активизации ДРГ Украины после подрыва Каховской ГЭС', '
    После подрыва Каховской гидроэлектростанции (ГЭС) активизировали украинские диверсионно-разведывательные группы (ДРГ), об этом заявил российский военный с позывным Таган. Он уточнил, что до этого такое в принципе не было возможно, поскольку Днепр полностью контролировался Вооруженными силами России.
  ', 1690693633, 'https://lenta.ru/news/2023/07/30/drg/', -6610949488985590664);
INSERT INTO public."NewsRss" VALUES (65058, 'Experience — не просто опыт. Interface — не просто экран', 'Как только ни мучают аббревиатуры UX и UI. Их используют, как хотят и где хотят: от скромных названий в вакансиях до лекций на больших площадках. И всё равно мало кто понимает, что они из себя представляют. Их путают, упрощают значения или присваивают чужие.&nbsp;Меня зовут Илья Шапеев, сейчас я проджект-менеджер на web-проектах в дизайн-студии ЦЕХ, а в прошлом — UX-дизайнер. В статье расскажу о том, как я пытался разобраться в определениях UX, UI, почему их недооценивают и почему важно понимать суть своей специальности. Читать далее', 1690641045, 'https://habr.com/ru/articles/751246/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751246', -1039510800247062620);
INSERT INTO public."NewsRss" VALUES (65059, 'Маск пообещал оставить штаб-квартиру Twitter в Сан-Франциско', '
    Глава Twitter Илон Маск пообещал, что штаб-квартира компании останется в Сан-Франциско, несмотря на то, что многие компании «покинули город». Об этом он написал в своем Twitter-аккаунте. «Сан-Франциско, прекрасный Сан-Франциско! Хотя многие оставили тебя, мы всегда будем твоим другом», — заявил предприниматель.
  ', 1690693117, 'https://lenta.ru/news/2023/07/30/musksun/', 766115788101579883);
INSERT INTO public."NewsRss" VALUES (65061, 'Система автоматической разгрузки и загрузки дрона (Часть 1 — кратко)', '    Проблема разгрузки и загрузки грузов на дрон без участия человека - это основная проблема автоматизации доставки грузов с помощью дронов. Ключевой этап доставки, который требует присутствия человека, заключается в процессе физической загрузки и разгрузки грузов на дрон. Но у нас есть решение!  Подробнее', 1690633895, 'https://habr.com/ru/articles/751236/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751236', -1039506333481074780);
INSERT INTO public."NewsRss" VALUES (65062, 'Бывшая российская легкоатлетка высказалась о свободе слова в США', '
    Бывшая российская прыгунья в высоту Елена Куличенко высказалась о свободе слова в США. Спортсменка заявила, что американцы могут легко обсуждать политику и критиковать президента, однако свободы слова в стране нет. «Если начал рассуждать про ЛГБТ или высказываться на расовые темы — это все», — заявила она. 
  ', 1690692588, 'https://lenta.ru/news/2023/07/30/kulichenko/', -2719989005494277363);
INSERT INTO public."NewsRss" VALUES (65065, 'В Киеве Зеленского раскритиковали за атаку беспилотников на «Москву-Сити»', '
    Украинский режиссер Игорь Лопатенок раскритиковал Киев и президента Украины Владимира Зеленского за атаку беспилотников на «Москву-сити» утром 30 июля. По его словам, таким образом Украина пытается вывести из равновесия позицию президента России Владимира Путина, однако попытки не увенчаются успехом.
  ', 1690692360, 'https://lenta.ru/news/2023/07/30/lopatenok/', 8961234866142449790);
INSERT INTO public."NewsRss" VALUES (65068, 'Киев предпринял попытку атаковать Крым ночью с помощью беспилотников', '
    Министерство обороны России сообщило, что Украина ночью предприняла попытку атаковать Крым, использовав 25 беспилотных летательных аппаратов (БПЛА). 16 дронов были уничтожены с помощью систем ПВО, а остальные девять были подавлены средствами РЭБ и рухнули в акватории Черного моря.
  ', 1690691804, 'https://lenta.ru/news/2023/07/30/cromea_night/', -7212227190847357593);
INSERT INTO public."NewsRss" VALUES (65071, 'В Австралии спрогнозировали будущее Украины', '
    Научный сотрудник Австралийского института международных отношений Лоик Симоне заявил, что западные государства могут не принимать Украину в альянс даже после завершения конфликта, несмотря на обещания. Западные страны, не желающие видеть Украину в НАТО, могут использовать статус Крыма в качестве удобного предлога.
  ', 1690691760, 'https://lenta.ru/news/2023/07/30/zelenn/', -3716030483532909456);
INSERT INTO public."NewsRss" VALUES (65075, 'В Запорожье заявили об успешной контратаке военных России на Времевском выступе', '
    Председатель движения «Мы вместе с Россией» Владимир Рогов заявил, что российские военные успешно атаковали Вооруженные силы Украины (ВСУ) на Времевском выступе на запорожском направлении. Он отметил, что контратака произошла в районе села Старомайорское, бои идут за контроль над окраинами населенного пункта.
  ', 1690691640, 'https://lenta.ru/news/2023/07/30/vystup/', -3711751436095242448);
INSERT INTO public."NewsRss" VALUES (65077, '15 несложных видеоредакторов, доступных из России', 'Если вам нужно быстро смонтировать видеоролик для рекламной кампании или других целей, совсем не обязательно изучать сложные программы. Собрали 15 простых инструментов, с которыми справится даже новичок в видеомонтаже. Все они бесплатные, имеют бесплатную версию или их можно оплатить из России. Читайте новую подборку от редакции click.ru. Читать далее', 1690634595, 'https://habr.com/ru/companies/click/articles/751240/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751240', -669304809858854870);
INSERT INTO public."NewsRss" VALUES (65082, 'Russ Cox makes the case for coroutines', '

  

    
    
    
    
    
  





  
      
    
#​469 — July 18, 2023
Unsub  |  Web Version

    
    Go Weekly

  



  
  A Rationale for Using Coroutines in Go — Many of the initial reactions to this suggestion by Russ Cox to introduce coroutines to Go were negative, with folks instead preferring Go’s existing channels based approach for the problems coroutines can solve. Nonetheless, there are some interesting and specific use cases for coroutines in Go, such as when iterating over generic collections, and Russ tries to convince us of their merit here. Luckily, it''s all possible "without language changes".
  Russ Cox 



  
  govulncheck 1.0 Released — We featured Go’s new vulnerability management tool last year when Julie Qiu gave an overview of the project. Now she’s back with a release ready to put into production. It statically analyzes your code and uses the Go Vulnerability Database to highlight relevant, known vulnerabilities.
  Julie Qiu (The Go Security Team) 



  
  Go! Experts at Your Service — Do you need help filling skill gaps, speeding up development &amp; creating high performing software with Go, Docker, K8s, Terraform and Rust? We’ll help you maximize your architecture, structure, tech-debt and human capital.
  Ardan Labs Consulting sponsor



  
  The Gorilla (Project) Reawakens — Gorilla is/was a suite of packages for building Go webapps (Mux remains a popular HTTP router option) but the packages sadly went into an “archive only” mode last year. A team of developers is in the early stages of resurrecting the project – watch this space.
  Gorilla Web Toolkit Maintainers 



  
  Analyzing Go Build Times — Go’s compiler is pretty quick, but John was curious was what factors affect compile times. In this article he used the 350,000 lines of the Istio project to put Go through its paces, try out some ideas, and ultimately came up with some tips.
  John Howard 


IN BRIEF:


Russ Cox continues with proposing new ideas: this time he suggests the addition of a untyped zero value identifier called zero to play a nil-like role in a broader variety of scenarios.


🔟 Ten years after writing Go: The Good, the Bad, and the Meh, author Carl M Johnson reflects on his ten years using Go since then – most of his points have stood the test of time, with generics and Go''s backwards compatibility promise providing some unanticipated benefits.


Jaana Dogan is really digging GitHub''s Copilot 🐦 for writing interface boilerplate code.


Go 1.21 Release Candidate 3 has been released.






  
  Monitor, Test and Debug your APIs with APIToolkit — A toolbox for building and maintaining APIs better than ever. Test and validate all API requests, and spot bugs faster.
  APIToolkit sponsor



  
  Event-Driven Architecture: What You Need to Know — The first in a series of posts on event-driven architecture and building a system using this paradigm in Go. This first post covers the what and why?
  Matt Boyle 



  
  5 Ways to Write a Go Database Model — Paul covers the vanilla approach, using struct mapping, SQL generators (like squirrel), a code generator (sqlc), and ORMs, pointing out pros and cons for each approach.
  Paul Boyd 

🛠 Code &amp; Tools

  




  
  Pop: Charm''s Latest Project Tackles Email — The Charm folks have a well earned reputation for producing useful Go powered tools and libraries and Pop, essentially a modern way to send emails from the terminal, looks to be no exception.
  Charm 



  
  ntp 1.2: A Simple NTP Client Package for Go — For querying your Network Time Protocol server of choice for the current time.
  Brett Vickers 



  
  So You’re Still Using Infrastructure as Code? — With Encore''s Infrastructure SDK: No manual work to run locally, Preview Environments for each PR, and zero tedious IaC.
  Encore sponsor



  
  Sarama 1.40: A Go Library for Apache Kafka — Originally created by Shopify, it appears IBM has now taken over the reins as Shopify wants to bind against librdkafka in future instead.
  IBM 



  
  Go Rate Limiter 0.3: A Blocking ''Leaky-Bucket'' Rate Limit Implementation — The ‘bucket’ gets refilled based upon the time elapsed between requests. v0.3 sees a return to development after a pause for a couple of years and offers a “more efficient internal implementation” without any external changes.
  Uber 



Jobs


  Find a Job Through Hired — Hired makes job hunting easy-instead of chasing recruiters, companies approach you with salary details up front. Create a free profile now.
  Hired 
  



📰 The Go-powered RSS reader

  



  
  goread: A Terminal-Based RSS / Feed Reader — If you''re tired of social news sites like Twitter or Reddit chopping and changing about, following a variety of RSS or Atom feeds remains a great option, and there''s a Go-flavored terminal client built around Bubble Tea you can try.P.S. Go Weekly has its own RSS feed if you want to test it out.
  Adam Piaseczny 



  





', 1689638400, 'https://golangweekly.com/issues/469', 431000655363206856);
INSERT INTO public."NewsRss" VALUES (65084, 'Зачем корпорации приходят в децентрализованные социальные сети', 'Интернет задумывался как открытый и децентрализованный инструмент для обмена информацией. Однако сеть прошла этап стремительной коммерциализации, и значительная её часть оказалась под контролем узкого круга ИТ-компаний. Участники сообщества, которым не нравится такой расклад, пытаются вернуть старый добрый веб с помощью децентрализованных платформ и протоколов вроде ActivityPub, XMPP или Nostr. Однако корпорации также проявляют интерес к этим технологиям — в том числе с целью расширить свою аудиторию. Мы решили взглянуть, как развивается противостояние. Читать далее', 1690647729, 'https://habr.com/ru/companies/vasexperts/articles/750270/?utm_source=habrahabr&utm_medium=rss&utm_campaign=750270', -7957493186127530839);
INSERT INTO public."NewsRss" VALUES (65090, 'Answering all the big questions', '

  

    
    
    
    
    
  





  
      
    
#​467 — July 4, 2023
Unsub  |  Web Version

    
    Go Weekly

  



  
  Frequently Asked Questions About Go — Did you know there''s an official Go FAQ? It''s been around forever, but somehow we’d not run into it it before.. 😅 It’s packed with interesting stuff and worth a flip through. Some of our favorites:


What compiler technology is used to build the compilers?
Is there an official Go style guide?
Why does Go do garbage collection?
What''s the origin of the gopher mascot?

  The Go Team 



  
  How Grab Uses Its Own Go Module Proxy — The team behind Grab, a popular ‘super-app’ in Southeast Asia, relies on a large Go monorepo for its backend dev projects and they use the Athens Go module store and proxy to make their dev process smoother and, in particular, to reduce module fetching times.
  Jerry Ng (Grab) 



  
  Go! Experts at Your Service — Do you need help filling skill gaps, speeding up development &amp; creating high performing software with Go, Docker, K8s, Terraform and Rust? We’ll help you maximize your architecture, structure, tech-debt and human capital.
  Ardan Labs Consulting sponsor



  
  Proposal: Let''s Change the pprof Mutex Profile in Go 1.22 — This is, admittedly, a niche topic. The idea is to measure contention based on how many goroutines are blocked on a mutex rather than the number of OS threads (which may be just one). For example, if you hold a mutex for 10ms and several goroutines wait for it, only 10ms total contention would currently be recorded.
  Russ Cox 


IN BRIEF:


📅 GopherCon is taking place this September in San Diego and the final schedule is now up with Erik St Martin and Russ Cox kicking things off, and talks and workshops from numerous fantastic gophers.


🇮🇳 GopherCon India is taking place this September, too.


🔈 Looking for something to listen to? Preslav Rachev shares a list of his favorite podcasts for Go developers.


gomock is no longer being maintained by the core team with Uber''s fork now recommended instead.


Last but not least, GopherCon Europe has just wrapped up in Berlin and it looks like 🐦 everyone had a fantastic time.






  
  ▶  MIT 6.824 Distributed Systems — It’s from 2020, but this playlist did the rounds on social media recently and what I’ve watched so far has been good. Prof. Robert Morris tackles the broad concepts of distributed systems, including fault tolerance, replication, and concurrency control. It’s broadly language agnostic, though Go is used for the main coding sections, such as the lecture on building a consensus algorithm in Go.
  Robert Morris (MIT) 



  
  Creating a Simple Fixed-Window Rate Limiter in Redis — A short and sweet example of using a Lua script from Go to perform atomic actions in Redis.
  Mahmud Ridwan 



  
  Rapidly Develop Golang Microservices In Kubernetes — Run your microservices locally and connect to real dependencies in a staging Kubernetes environment. Try our playground.
  Signadot sponsor



  
  About Structured Logging in Go 1.21 — We’ve mentioned the new structured logging (slog) package coming to Go 1.21 a few times recently, but Lukás pokes around, explains its interface, and how to use it today.
  Lukáš Zapletal 



  Adventures in Building a Go Container with Nix — One developer’s notes are often another developer’s treasure.
  James Williams 
  



  How to Deploy Your Existing Containers to OpenFaaS
  Alex Ellis (OpenFaaS) 
  

🛠 Code &amp; Tools

  



  
  Chroma 2.8: Pure Go Syntax Highlighter — Take source code and turn it into syntax highlighted HTML, ANSI colored text, or just grab the raw tokens in JSON. Brings most of the features of Pygments to Go and can use Pygments’ lexers and styles too. There’s an online playground where you can try it out. v2.8 adds support for ArangoDB Query Language and WebGPU Shading Language, plus more.
  Alec Thomas 



  
  Announcing GoReleaser v1.19: The Big Release — GoReleaser is, unsurprisingly, a tool for releasing Go projects. It offers cross-compilation, release to systems like GitHub and GitLab, nightly builds, Docker image creation, packaging, and more. v1.19 improves support for Nix, Winget, Homebrew, Krew, and Scoop, among other things.
  Carlos Alexando Becker 



  
  Encore: Declarative Infrastructure for Go — Define infrastructure directly in application code and get local, preview, and cloud environments automatically.
  Encore sponsor



  
  Mailpit 1.7: Email and SMTP Testing Tool — Built in Go, Mailpit is a general email testing tool and API for all developers. You can use it to view emails “sent” through its mock SMTP server, store emails, and even relay them on.
  Ralph Slooten 



  
  Zygo: A Lisp Interpreter in 100% Go — “Written in Go and plays nicely with Go programs and Go structs,” it could provide you with an interesting way to provide a DSL within Go apps.
  Jason E. Aten, Ph.D. 



  
  Watermill: Library for Building Event-Driven Apps — A library for working with message streams (over numerous channels like Kafka, RabbitMQ, HTTP or even MySQL binlogs) to build event driven apps.
  Three Dots Labs 




Jobs


  Find a Job Through Hired — Hired makes job hunting easy-instead of chasing recruiters, companies approach you with salary details up front. Create a free profile now.
  Hired 
  







GoLand 2023.2 EAP7
↳ Now includes a LSP API for plugin developers.


Centrifugo v5
↳ Scalable real-time messaging server.


TiDB 7.2
↳ Distributed MySQL-compatible HTAP database. (Repo.)


FerretDB 1.5
↳ MongoDB alternative built atop Postgres (or, now, SQLite).


env 9.0
↳ Parse environment variables into a struct.


Goxygen 0.6
↳ Generate a full stack Web project. Now with Go 1.20 support.


Column 0.4
↳ High-performance, columnar in-memory store.


Kubo 0.21
↳ IPFS implementation in Go





  





', 1688428800, 'https://golangweekly.com/issues/467', 998454208411889352);
INSERT INTO public."NewsRss" VALUES (65151, 'Появились кадры бизнес-центра «Око-2» в «Москва-сити» после атаки БПЛА', '
    Telegram-канал Mash опубликовал кадры здания бизнес-центра «Око-2» в «Москва-сити» после атаки БПЛА. На видео видно, как пострадало здание — на первых шести этажах повреждено остекление. Площадь повреждений — 40 квадратных метров. Ранним утром 30 июля в башню «Москвы-сити» попал украинский беспилотник.
  ', 1690687620, 'https://lenta.ru/news/2023/07/30/oko2bpla/', 3581631283924941991);
INSERT INTO public."NewsRss" VALUES (65064, 'Устройство цифровой индикации (УЦИ) для токарного станка', 'Устройства цифровой индикации (УЦИ) набирают все большую и большую популярность среди домашних мастеров, имеющих в своем распоряжении в личной мастерской разнообразное станочное оборудование. УЦИ обеспечивает удобную индикацию положения режущего инструмента, позволяет работать в разных координатах с оперативным переключением от одной точки привязки к другой, позволяет задавать произвольную точку привязки для удобства отсчета. Несмотря на постоянное совершенствование и снижение стоимости, системы УЦИ остаются больше уделом профессиональной и полупрофессиональной деятельности. Для использования в личной мастерской такие устройства пока еще слишком дороги. По этой причине энтузиастами разрабатываются и любительские устройства, позволяющие реализовать аналогичные функции. Одно из таких устройств и будет описано ниже. Читать далее', 1690665364, 'https://habr.com/ru/articles/751266/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751266', -1039512312075550812);
INSERT INTO public."NewsRss" VALUES (65067, 'Неизменная ценность ручных тестировщиков: важность и преимущества в эпоху автоматизации', 'В современном быстро развивающемся мире информационных технологий, где каждый день появляются новые программные продукты и веб-приложения, обеспечение высокого качества программного обеспечения становится все более актуальной задачей. Тестирование играет ключевую роль в этом процессе, позволяя выявлять ошибки и дефекты в приложениях до их попадания к конечным пользователям.С развитием технологий и применением автоматизации тестирования, многие специалисты опасаются, что ручное тестирование может быть вытеснено автоматизированными решениями. При этом стоит отметить, что ручное тестирование имеет свои особенности и преимущества, которые делают его неотъемлемой частью процесса обеспечения качества программного обеспечения.В данной статье мы рассмотрим почему ручные тестировщики не исчезнут в эпоху автоматизации тестирования. Мы проанализируем разнообразие видов тестирования, где ручные тестировщики остаются незаменимыми. Рассмотрим роль ручных тестировщиков в тестировании сложных систем, а также их способности выявлять проблемы, которые могут ускользнуть от автоматизированных инструментов. Также обсудим преимущества ручного тестирования, а также то, как ручные тестировщики могут дополнить и улучшить процесс автоматизации тестирования.Сегодня вход в область тестирования стал непростым заданием, и мы также рассмотрим трудности, с которыми сталкиваются начинающие специалисты, желающие заняться ручным тестированием. Поговорим о путях решения этих проблем, а также о перспективах карьерного роста для ручных тестировщиков. Читать далее', 1690648254, 'https://habr.com/ru/articles/751252/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751252', -1039157375978209372);
INSERT INTO public."NewsRss" VALUES (65070, '«Port Knocking» на устройствах MikroTik', 'Port Knocking - это метод, который позволяет скрыть открытые порты на сервере, а также скрыть сам факт существования сервера в сети. Он основывается на использовании последовательности подключений к определенным портам, которые заранее определены администратором. Если эта последовательность верна, то система открывает доступ к нужному порту. Читать далее', 1690612025, 'https://habr.com/ru/articles/751178/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751178', -1037296047479095388);
INSERT INTO public."NewsRss" VALUES (65074, '[Перевод] Мы можем добыть воду на Луне, направив на неё солнечный свет', 'Одна из наиболее часто обсуждаемых проблем, возникающих в начале пути освоения космоса, - как доставить с Земли ресурсы, необходимые для жизни. Обычно это две вещи - вода и кислород, но, к счастью, кислород можно получить путём расщепления молекулы воды, поэтому наиболее важным ресурсом, который мы можем найти в космосе, является вода. На языке космических ресурсов воду принято называть «летучим веществом», и именно она находится в центре внимания многих планов по использованию местных ресурсов на Луне, Марсе и в других местах. Некоторые из этих планов были хорошо продуманы, другие - нет. Один из них, в частности, продемонстрировал многообещающие перспективы, когда в 2019 году он был отобран в рамках финансирования Института перспективных концепций НАСА (NIAC), и здесь мы рассмотрим его более подробно.Концепция, официально известная как «Термическая добыча льда на холодных телах Солнечной системы» (или просто «термическая добыча») - детище Джорджа Соуэрса, эксперта по космическим ресурсам и профессора машиностроения в Горной школе Колорадо. Концепция, лежащая в основе проекта, удивительно проста и знакома каждому, кто в детстве играл с увеличительным стеклом. Читать далее', 1690635302, 'https://habr.com/ru/articles/751164/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751164', -1039899347416285276);
INSERT INTO public."NewsRss" VALUES (65079, 'В Иране чиновника отстранили по подозрению в однополых отношениях', '
    В Иране чиновника отстранили по подозрению в однополых отношениях, об этом сообщает издание Daily Mail. По его информации, речь идет о Резе Цагати, руководителе отдела культуры и исламского руководства провинции Гилян, ориентированого на благочестие, консерватизм и обязательное ношение хиджаба.
  ', 1690691202, 'https://lenta.ru/news/2023/07/30/iran/', 2038429207782028980);
INSERT INTO public."NewsRss" VALUES (65083, 'В Приволжье девять человек погибли из-за непогоды', '
    МЧС России сообщило, что десятки человек пострадали из-за непогоды в Приволжье. В ведомстве предупредили об опасных метеорологических явлениях, сохраняющихся на территории восьми субъектов Приволжского федерального округа с 29 июля. Пострадали 76 человек, девять из которых погибли.
  ', 1690690595, 'https://lenta.ru/news/2023/07/30/nepogoda/', 500338537544572479);
INSERT INTO public."NewsRss" VALUES (65087, 'Россиянам разъяснили правила установки печей на даче', '
    Депутат Госдумы от партии «Единая Россия», председатель Союза дачников Подмосковья Никита Чаплин в беседе с РИА Новости рассказал, как построить дачную печь, чтобы не устроить пожар в доме. Парламентарий посоветовал устанавливать печь сертифицированного заводского производства. 
  ', 1690689720, 'https://lenta.ru/news/2023/07/30/dachaaaa/', -5020519318506678295);
INSERT INTO public."NewsRss" VALUES (65066, 'Микросервисы в банке: на чем их лучше писать? Java/Kotlin, а может Go?', 'В июле в офисе РСХБ-Интех (технологической дочки Россельхозбанка) состоялся бесплатный митап для Java-разработчиков — RSHB Backend Dev Meetup. Обсудили Kotlin, Go, маппинг и разные аспекты бэкэнд-разработки. В числе докладчиков выступал Иван Кочергин, руководитель центра собственной разработки РСХБ-Интех. Иван более 10 лет занимается разработкой на Java, последние три года — на Kotlin. В своем докладе он сравнил, на чем лучше писать микросервисы в банке: Java, Kotlin или Go. Делимся расшифровкой доклада. Запись всего митапа можно посмотреть на Rutube. Читать далее', 1689266766, 'https://habr.com/ru/companies/rshb/articles/747898/?utm_campaign=747898&utm_source=habrahabr&utm_medium=rss', -6455656854212045344);
INSERT INTO public."NewsRss" VALUES (65069, 'Учимся разрабатывать REST API на Go на примере сокращателя ссылок', '
В этой статье мы напишем полноценный REST API сервис — URL Shortener — и задеплоим его на виртуальный сервер с помощью GitHub Actions.

Говоря «полноценный», я имею в виду, что это будет не игрушечный проект, а готовый к использованию:


мы выберем для него актуальный http-роутер,
позаботимся о логах,
напишем тесты: unit-тесты, тесты хэндлеров и функциональные,
настроим автоматический деплой через GitHub Actions и др.

Но важно понимать, что «готовый к продакшену» != «энтерпрайз».

Кратко обо мне: меня зовут Николай Тузов, я много лет занимаюсь разработкой на Go, очень люблю этот язык. Также веду свой YouTube-канал, на котором есть видеоверсия текущего гайда, с более подробными объяснениями. Читать дальше &rarr;', 1689254101, 'https://habr.com/ru/companies/selectel/articles/747738/?utm_campaign=747738&utm_source=habrahabr&utm_medium=rss', 1013046520827340212);
INSERT INTO public."NewsRss" VALUES (65073, 'Простые правила, которые помогают мне писать на Go без побочных эффектов', 'Роб Пайк сказал, что простое лучше, чем сложное. Я бы добавил: простое лучше, чем прикольное. Ведь Go спроектирован, чтобы писать программы в простом стиле.&nbsp;Сегодня я хочу поговорить про такие, казалось бы, очевидные вещи, как функции, интерфейсы и методы. Их особенности в Go. И правила, которые я выработал, чтобы писать их просто и понятно для коллег, для компьютера и для себя в недалеком будущем. Читать далее', 1689232200, 'https://habr.com/ru/companies/yadro/articles/747308/?utm_campaign=747308&utm_source=habrahabr&utm_medium=rss', -667428056804406710);
INSERT INTO public."NewsRss" VALUES (65076, '[Перевод] database/sql биндинги для YDB в Go', 'YQL&nbsp;— это SQL‑диалект, специфичный для&nbsp;базы данных YDB. YQL требует заранее объявлять имена и типы параметров запроса. Это обеспечивает высокую производительность и корректное поведение. В&nbsp;синтаксисе YQL параметры необходимо перечислять явно с&nbsp;помощью инструкции DECLARE. И этот нюанс YDB может&nbsp;быть неожиданным для&nbsp;пользователей традиционных баз данных. В&nbsp;статье раскрывается вспомогательный механизм, позволяющий писать привычные простые SQL‑запросы при&nbsp;работе с YDB. Читать далее', 1689172608, 'https://habr.com/ru/articles/747490/?utm_campaign=747490&utm_source=habrahabr&utm_medium=rss', -1038290154911510620);
INSERT INTO public."NewsRss" VALUES (65072, 'The one where Go keeps getting better', '

  

    
    
    
    
    
  





  
      
    
#​470 — July 25, 2023
Unsub  |  Web Version


✍️ It feels like there''s a particularly strong drive to improve Go lately, whether it''s through the ever growing number of proposals from folks like Russ Cox, the development of tools like govulncheck, or folks writing articles about how to write better code. Go''s a simple language with modest ambitions, but it''s not resting on its laurels and is actively continuing to get better all the time – long may it last!__Your editor, Peter Cooper
    
    Go Weekly

  



  
  An Overhaul of Inlining for Go 1.22 — Inlining is the concept of replacing a function call in a program with the contents of the function itself, thus avoiding the call. Go’s inliner has improved over the years, but the policies around when and what to inline have become a little out of date. The idea, then, is to implement a variety of tweaks that could introduce, Austin says, “significant performance improvements for Go applications”.
  Austin Clements et al. 



  
  A Preview of Ranging Over Functions — A new language proposal (yes, another one!) suggests adding two new types for/range can iterate over. The first (integers) is mostly syntactic sugar, but the second (functions) would allow iteration over custom collection types which is pretty huge.
  Eli Bendersky 



  
  Pass SOC 2, FedRAMP, HIPAA, and Other Audits With Ease — Meet compliance requirements, pass audits with minimal effort, and have complete visibility into kubectl access and behavior with Teleport by starting your free trial. The supported standards include SOC 2, FedRAMP, HIPAA, ISO 27001, PCI, and more.
  Teleport | goteleport․com sponsor



  
  How to Find and Fix Vulnerable Dependencies with govulncheck — Last week, we featured govulncheck’s 1.0 release, and now there’s an official tutorial on the Go site on using the tool to scan a Go program for vulnerabilities and the steps to take if you find anything.
  Go Documentation 



  
  Proposal: Let''s Make Go''s HTTP Request Multiplexer Better — http.ServeMux is an HTTP request multiplexer (or router, if you will) and there has been talk this year of making it better by adding support for HTTP method based routing and support for wildcards in paths. This has now turned into a proposal.
  Jonathan Amsterdam 


IN BRIEF:


We love it when the Go docs keep it real. From the Go Memory Model comes this gem: "If you must read the rest of this document to understand the behavior of your program, you are being too clever. Don''t be clever."


The latest episode of the Go Time podcast covers ▶️ "the tools we love" – specifically, the dev-related tools the hosts and guests enjoy, most of which are listed in the show notes even if you don''t want to listen to the show.


Vercel gives an update on their progress in porting Turborepo (a JS/TS build tool) from Go to Rust. They wrote more about why they''re making the move a few months ago.






  
  Common Pitfalls in Go Benchmarking — “While these pitfalls are presented in Go, they exist in any programming language or environment, so the lessons learned here are widely applicable.”
  Eli Bendersky 



  
  Getting Friendly with CPU Caches — Understanding how to make your code cache-friendly can result in significant performance gains but be sure you understand the risks and tradeoffs therein.
  Miki Tebeka and William Kennedy 



  
  Using Cobra to Build Go-Powered CLIs — A step by step tutorial for creating a basic CLI app using the Cobra approach.
  Joseph Udonsak 



  
  “DevOps Workload Has Dropped by 90% for Services Migrated to Encore” — Check out Bookshop.org''s ongoing journey from a Ruby on Rails monolith to a Go microservices architecture.
  Encore sponsor



  
  A Gentle Introduction to Pointers in Go — Very short and elementary, but.. “if you’re a bit fuzzy on exactly what pointers and how they work, it should help you out!”
  Alex Edwards 



  From 26 Minutes to 20 Seconds: Using pprof to Optimize Large GraphQL Operations in Go
  WunderGraph 
  

🛠 Code &amp; Tools


  
  ff 3.4: A ''Flags-First'' Package for Configuration — Provides an opinionated way to populate a flag.FlagSet with configuration data from the environment via cmd line args, config file, or environment variables.
  Peter Bourgon 



  
  Vegeta: An HTTP Load Testing Tool and Library — A Go-powered load testing approach with lots of customization potential, a built-in plotting tool, and even a way to render real-time reports in your terminal.
  Tomás Senart 



  
  Get Started with Temporal and Go — Build apps with Temporal + Go by setting up your development environment, then exploring how Temporal Applications work.
  Temporal Technologies sponsor



  



  
  ov: Feature-Rich Terminal-Based Text Viewer/Pager — Aims to replace less, more, tail -f and watch in one.
  Noboru Saito 



  
  Risor: An Embeddable Scripting Language Written in Go — Formerly known as Tamarin, Risor code (which feels a bit like a hybrid of Go and Python and can use the Go standard library) gets compiled to bytecode and run on a small pure Go VM. GitHub repo.
  Curtis Myzie 



  
  go-sse 0.6: Spec-Compliant Server-Sent Events (SSE) Library — Server Sent Events is a Web API supported by all major browsers that lets servers stream/send messages to (listening) pages at will.
  Teodor Maxim 



Jobs


  Find a Job Through Hired — Hired makes job hunting easy-instead of chasing recruiters, companies approach you with salary details up front. Create a free profile now.
  Hired 
  






pdfcpu 0.4.2
↳ A PDF processor/parser written in Go.


go-git 5.8
↳ Pure Go git implementation in a library.


GoToSocial 0.10.0
↳ ActivityPub social network server.


Fiber 2.48.0
↳ Express.js-inspired Web library for Go.


Micro 4.3.0
↳ API first development platform.


Dive 0.11
↳ Tool to explore each layer in a Docker image.





  





', 1690243200, 'https://golangweekly.com/issues/470', 705526718586318536);
INSERT INTO public."NewsRss" VALUES (65078, '5 книг по Golang для начинающих разработчиков: на что стоит обратить внимание', 'Привет, Хабр! Сегодня поговорим о Golang, вернее, о хороших книгах, которые написаны для начинающих разработчиков. Возможно, какие-то из этих книг пропустили в своё время и более опытные программисты — если так, стоит обратить на них внимание. Если же вы можете порекомендовать книги по Go, которые понравились именно вам, пишите в комментариях, обсудим и их. Ну а пока — поехали. Читать далее', 1688986205, 'https://habr.com/ru/companies/ru_mts/articles/747040/?utm_campaign=747040&utm_source=habrahabr&utm_medium=rss', 942816545387458931);
INSERT INTO public."NewsRss" VALUES (65080, '5-1 не в вашу пользу: 5 ошибок при создании игры', '«Блин, вот&nbsp;бы создать свою игру, да&nbsp;чтобы с&nbsp;этим да&nbsp;этим.....»&nbsp;— наверное каждый человек не раз сталкивался с подобным желанием, но 95% подобных желаний оканчивались ничем. В этой статье я хочу рассказать о том, как я делал свою игру и какие ошибки совершал. Учитесь на ошибках! Читать далее', 1690658476, 'https://habr.com/ru/articles/751258/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751258', -1037292604257501276);
INSERT INTO public."NewsRss" VALUES (65081, 'Основы Go: функции', 'Автор статьи: Рустем ГалиевСегодня мы рассмотрим, как писать и вызывать функции в Go. Мы также изучим, как правильно обрабатывать ошибки в функциях, и узнаем об использовании функций в качестве типов данных. Попутно мы будем использовать структуры управления if, for и switch в Go. Читать далее', 1688641441, 'https://habr.com/ru/companies/otus/articles/746276/?utm_campaign=746276&utm_source=habrahabr&utm_medium=rss', -6450078485257247264);
INSERT INTO public."NewsRss" VALUES (65086, 'Go, meet Python. Python, meet Go.', '

  

    
    
    
    
    
  





  
      
    
#​468 — July 11, 2023
Unsub  |  Web Version

    
    Go Weekly

  



  
  Finding Bugs with Fuzzing — The final post in a series about fuzz testing in Go (you can start here) wraps things up with a practical example of finding and fixing a subtle bug in Go code using the process.
  John Arundel 



  
  Some First Impressions of Go 1.21 — The impending 1.21 release feels more significant than other recent releases due to the items mentioned in this post, including new slice/map API functions (including many that take advantage of generics), structured logging, and the (experimental, opt-in only for now) tweak to loop variable capture.
  Jason Fulghum (DoltHub) 



  
  Certificate-Based MFA, RBAC, and SSO with Teleport — Implement industry best practices for Kubernetes access with minimal configuration. Easily enforce MFA, RBAC, and SSO using identity-based short-lived X.509 certificates for engineers and service accounts by starting your trial today.
  Teleport | goteleport․com sponsor



  
  Wazero 1.3.0: WebAssembly Runtime for Go Developers — The goal here is being Go 1.21 ready (since it’s released next month). That’s important because Go 1.21 will directly support compiling to WASI-backed WASM which, in turn, Wazero will be able to run. Now we’re just waiting to see if Wazero can be compiled to WASM and run by itself.. 😅
  Tetrate Labs 



  
  Pygolo: Extend Python with Go and Vice Versa — A new way to embed or extend the Python interpreter with Go. There’s a full guide to using it, but Pygolo does most of the heavy lifting taking care of types, modules, exceptions, and more.
  Domenico Andreoli 


IN BRIEF:


sqlc is a popular tool for working with SQL that compiles queries into type-safe Go code, and its creators have great news: they will now be working on sqlc full-time.


🇪🇺 GopherCon Europe 2023 took place a few weeks ago and Benjamin Bryant has shared this ''totally nonprehensive'' recap of how it went, focused mostly on the nice people he met which, to be fair, is what conferences are all about.


🇺🇸 Don''t forget that the US outing of GopherCon is taking place this September in San Diego, CA.


In the wild, gophers tend to live alone, and many Go-programming gophers work alone too. Last week''s Go Time podcast focused ▶️ on solo gophers and the realities of working on a team of one.






  
  Go Sync or Go Home: WaitGroup — What does WaitGroup have that channels don’t? (Quickly followed up with Go Sync or Go Home: ErrGroup.)
  Yarden Laifenfeld 



  
  Workflows as Actors: Is It Really Possible? — Discover the Actor Model and its importance in system design patterns. Then, build Temporal Workflows that act like Actors in Go!
  Temporal Technologies sponsor



  
  Start Fast: Booting Go Programs Quickly — “A quick-booting program should be a source of pride,” says Efron, who really, really, really wants the binary serving his blog to spin up in milliseconds.
  Efron Licht 



  ▶  Debugging Go CLI Programs with Visual Studio Code — Quick 4 minute demo.
  Josh Duffney 
  

🛠 Code &amp; Tools


  
  ghw 0.12.0: Go Hardware Discovery and Inspection — Find out things about the memory, CPU, storage, network support, and similar things of the host computer. Focused on Linux and Windows, with partial macOS support.
  Jay Pipes 



  
  Act: Run Your GitHub Actions Locally — Run act and it looks at your repo’s GitHub Actions, uses Docker to grab the necessary images, and runs the tasks locally.
  Nektos 



  
  eBPF Go 0.11.0: Pure Go Library to Work with eBPF Programs — A library and toolchain that can let you write eBPF programs in assembly or C within your Go code, lets you link against various hooks, and more. Examples here.
  Cilium 


💡 eBPF is a Linux-oriented (though not Linux exclusive) technology to run certain programs in a sandbox within kernel space. It''s more fun than it sounds, honest.


  
  Add Fully-Featured Auth to Your Go App with Two Lines of Code — Easy, secure, and affordable: pick three. FusionAuth is auth built for devs, by devs.
  FusionAuth sponsor



  
  MacDriver 0.4: Native Mac API Access for Go — A toolkit for working with Apple/Mac APIs and frameworks in Go, formed of both bindings for Objective C and wrapped versions of certain frameworks.
  Jeff Lindsay 



  




fq 0.7
↳ Imagine jq for binary formats.


faasd 0.17
↳ Lightweight FaaS engine. Think OpenFaas sans Kubernetes.


Go OpenAI 1.13
↳ Use ChatGPT, GPT-4, DALL-E, and friends.


Gobot 2.1.1
↳ Robotics and IoT framework.


go-simd
↳ Very niche, but a ARM-focused SIMD implementation.





Jobs


  Find a Job Through Hired — Hired makes job hunting easy-instead of chasing recruiters, companies approach you with salary details up front. Create a free profile now.
  Hired 
  



🚎 Roll up for the Go mystery tour..

  



  
  The Ultimate Go Tour for Intermediate Developers — The folks at Arden Labs teach Go for a living, so this set of free tutorials (written atop the Go Playground) is a great start for experienced developers who want to learn Go.
  Arden Labs 



  





', 1689033600, 'https://golangweekly.com/issues/468', 309403465424203464);
INSERT INTO public."NewsRss" VALUES (68085, 'Daily Express: Британия готовит ВСУ к захвату Крыма - URA.RU', '', 1690701780, 'https://news.google.com/atom/articles/CBMiIGh0dHBzOi8vdXJhLm5ld3MvbmV3cy8xMDUyNjcxMjk20gEkaHR0cHM6Ly9hbXAudXJhLm5ld3MvbmV3cy8xMDUyNjcxMjk2?oc=5', -5793662255962179003);
INSERT INTO public."NewsRss" VALUES (65085, 'Обработка ошибок в go в 2023 г', 'В go нет исключений. Разработчики, начинающие знакомиться с go, часто не знают как лучше всего обработать ошибку, как её отобразить в логах и что с ней делать дальше.Рассмотрим все варианты, которые можно встретить в проектах на golang в 2023 году. Читать далее', 1688474478, 'https://habr.com/ru/articles/745876/?utm_campaign=745876&utm_source=habrahabr&utm_medium=rss', -1039512714145771612);
INSERT INTO public."NewsRss" VALUES (65089, 'Оптимизация памяти и управление сборщиком мусора в Go: GOGC и GOMEMLIMIT', 'Всем привет, меня зовут Нина Пакшина, я работаю Golang разработчиком в Лента Онлайн в команде операций.В данной статье я расскажу о том, как управлять сборщиком мусора в Go, как оптимизировать потребление памяти приложением и защититься от ошибки out-of-memory. Читать далее', 1688371202, 'https://habr.com/ru/articles/742402/?utm_campaign=742402&utm_source=habrahabr&utm_medium=rss', -1039156501437558876);
INSERT INTO public."NewsRss" VALUES (65092, 'Анонимная сеть в 200 строк кода на Go', 'Реализации анонимных сетей всегда стремятся быть как можно проще, доступнее для понимания, как на теоретическом, так и на программном уровнях. Такие условия становятся необходимыми вследствие одного из основных принципов построения безопасных программ — чем проще объяснить, тем легче доказать. Но к сожалению теория часто может расходиться с практикой, и то, что легко объяснить в теории, может быть проблематично объяснять на коде. Вследствие этого, можно сказать just-for-fun, у меня появился вопрос: можно ли реализовать анонимную сеть настолько малую, чтобы её программный код смог понять даже начинающий программист за короткое время?  Читать далее', 1688186352, 'https://habr.com/ru/articles/745256/?utm_campaign=745256&utm_source=habrahabr&utm_medium=rss', -1039509219653005404);
INSERT INTO public."NewsRss" VALUES (65088, '[Перевод] 5 привычек, при помощи которых нейробиологи поддерживают свой мозг в здоровом состоянии', 'В вирусном видеоролике на TikTok, набравшем более 10 млн просмотров, аспирантка факультета неврологии Эмили Макдональд рассказывает о трех вещах, которые она делает каждый день для защиты своего мозга: не хватается за телефон по утрам, думает о позитивном и избегает переработанных продуктов.Советы, которые Макдональд дает в своем видео, не так уж плохи, рассказали Insider два нейробиолога. Но есть еще много других способов сохранить мозг здоровым, и за этим стоит наука.Джейсон Шепард, доцент кафедры нейробиологии Университета штата Юта, и Талия Лернер, доцент кафедры нейронаук Северо-Западного университета, рассказали Insider о том, что они рекомендуют и делают для поддержания здоровья мозга. Читать далее', 1690618261, 'https://habr.com/ru/articles/751160/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751160', -1038280866300199004);
INSERT INTO public."NewsRss" VALUES (65091, 'Блогерша рассказала о странной традиции жителей Испании', '
    Одна из самых странных и необычных традиций испанцев — это перепрыгивать через младенцев во время религиозного праздника. В разговоре с «Лентой.ру» блогер, журналист, автор Telegram-канала о жизни в Европе Алена Бердова рассказала о значении этого ритуала для жителей страны.
  ', 1690689607, 'https://lenta.ru/news/2023/07/29/baby/', -1632864542215046523);
INSERT INTO public."NewsRss" VALUES (65093, 'Сальдо заявил о концентрировании обстрелов гражданской инфраструктуры Херсонщины', '
    Врио главы Херсонской области Владимир Сальдо заявил, что Вооруженные силы Украины (ВСУ) концентрируют обстрелы гражданской структуры в регионе, за небольшой промежуток времени выпускаются десятки снарядов. По его словам, обстрелы продолжаются примерно с одинаковой интенсивностью.
  ', 1690688876, 'https://lenta.ru/news/2023/07/30/saldo/', -6651738453409513226);
INSERT INTO public."NewsRss" VALUES (65094, 'Раскрыты доходы SpaceX', '
    На систему спутникового интернета Starlink может приходиться до 40 процентов доходов компании SpaceX в 2023 году. Издание SpaceNews раскрывает, что компания рассчитывает в 2023 году заработать вдвое больше, чем в 2022-м. Если прогнозы SpaceX сбудутся, то она заработает более 8 миллиардов долларов.
  ', 1690688806, 'https://lenta.ru/news/2023/07/30/spacex/', -3715277677401012160);
INSERT INTO public."NewsRss" VALUES (65095, 'В Москве и области сняли ограничения на полеты', '
    В Московской воздушной зоне, в которую входят столица и Московская область, сняли ранее введенные ограничения на полеты любых воздушных судов. Отмечается, что в общей сложности из-за действовавших ограничений были задержаны около 20 рейсов. Часть самолетов была направлена на запасные аэродромы.
  ', 1690688398, 'https://lenta.ru/news/2023/07/30/polety_msk/', -5306769382596082666);
INSERT INTO public."NewsRss" VALUES (65147, 'Пишем свою мини-СУБД на Golang (Часть 1)', 'В этой статье, мы начнем подготовку к созданию своей небольшой базы данных, используя Go и его стандартную библиотеку. Читать далее', 1688140018, 'https://habr.com/ru/articles/745194/?utm_campaign=745194&utm_source=habrahabr&utm_medium=rss', -1039908624499552348);
INSERT INTO public."NewsRss" VALUES (65200, ' #468895', 'Из обсуждения телефонных мошенников.Наталья: Недавно звонил товарищ следователь. По поводу мошеннический действий с моим счетом. Знаете, как я обрадовалась? 20 минут рассказывала, как мой сосед машины меняет раз в 6 месяцев. Наверное, подпольный банкир. А дама из дома напротив водит мужчин. Она точно проститутка и налогов не платит. Товарищ следователь заикался. Пытался вставить слово. Потом сам бросил трубку.', 1645686661, 'http://bashorg.org/2022/02/24/468895.html', 5986381409087242168);
INSERT INTO public."NewsRss" VALUES (65201, ' #468894', 'xxx: интересно, сколько интересно щас емкость всего инета?xxx: нашел: Объем общемировых данных вырастет с 33 зеттабайт в 2018 году до 175 в 2025.xxx: я таких приставок даже не знаюyyy: да бляyyy: 99 процентов это порноyyy: остальные 99 процентов это видео с котикамиyyy: еще 99 процентов это порно с котиками.yyy: и того 297 процентов говна', 1645685151, 'http://bashorg.org/2022/02/24/468894.html', 5986381409087131576);
INSERT INTO public."NewsRss" VALUES (65202, ' #468893', 'Покупка гантелей по объявлениям - это сказка.&quot;Гантели 20 кг, цена 6 т.р.&quot;Прикидывваю - 40 кг за 6 000 р, это 150 рублей за кило. Выгодная цена за приличные гантели. Приезжаю, вижу гантели как на фото, даю 6 т.р., прошу помочь дотащить до такси. &quot;Нет вы не поняли - 6 т.р. за каждую!&quot;. Ну блин, ну ок, раз взял такси и приехал, даю ещё 6 т.р. За хорошие гантели 20 кг не особо жалко. А стоп - что-то они больно лёгкие для 20 кг! &quot;Нет, вы не поняли - 20 кг весят ДВЕ гантели!&quot;.', 1645685109, 'http://bashorg.org/2022/02/24/468893.html', 5986381409086873528);
INSERT INTO public."NewsRss" VALUES (65226, ' #468886', 'Straga: Я вчера отхватил супер комплимент на всю мою жизнь. Дочка 4 года с зади подкралась. Сначало закинула одну ногу на плечо, потом вторую, поудобнее уселась на моей шее, руками по волосам погладила и сказала: Какой Красавчик!!!Олег: Я так женился))', 1645677964, 'http://bashorg.org/2022/02/24/468886.html', 5986381409087352328);
INSERT INTO public."NewsRss" VALUES (65203, ' #468892', 'xxx: Представляю себе время, когда миллениалы постареют, и поколение их внуков будет смотреть на все эти шкафы из Икеи, наполненные фигурками Человека Паука и коллекционными изданиями Гарри Поттера, и недоумевать, как мы сейчас недоумеваем из-за сервантов с хрусталём.yyy: – Дед ну зачем тебе столько пластиковых фигурок из аниме?– Вот помру тогда и выкините!zzz: Учитывая, сколько некоторые уже сейчас стоят, к тому времени, скорее, деда выкинут, а половина родственников переубивают друг друга из за фигурок.', 1645685042, 'http://bashorg.org/2022/02/24/468892.html', 5986381409086975928);
INSERT INTO public."NewsRss" VALUES (65205, 'Дни рождения', '30 июля исполняется 75 лет президенту ИМЭМО РАН, академику РАН Александру Дынкину  Его поздравляет ректор МГИМО, академик РАН Анатолий Торкунов:  — Уважаемый Александр Александрович! Дорогой Саша! Ты прекрасно знаешь, что в твой возраст никто не верит, не веришь в него и ты сам, но это не повод не поздравить тебя! За несколько ярких десятилетий нашей дружбы и профессионального общения не перестаю восхищаться твоим талантом востребованного практикой ученого и гениального организатора больших коллективов и сложных проектов. Палитра твоих интересов включает поистине всю мировую экономику и международные отношения, а инженерное происхождение придает твоим изысканиям должную устойчивость и системность.', 1690579927, 'https://www.kommersant.ru/doc/6095508', -3309405148429691981);
INSERT INTO public."NewsRss" VALUES (65206, ' #468891', 'Жизнь за границей.Звонят мне спамеры.- Вы говорите по русски?Я отвечаю - Только для граждан Китая.- Ой, простите, ошибка.. - и сбросили.', 1645683182, 'http://bashorg.org/2022/02/24/468891.html', 5986381409087094712);
INSERT INTO public."NewsRss" VALUES (65209, 'Неопределенность сильнее интеллекта // Венчурные инвестиции в мире продолжают падать', 'Мировой венчурный рынок сжимается уже на протяжении полутора лет, следует из обзора компании KPMG Private Enterprise. Во втором квартале 2023 года глобальные венчурные инвестиции составили лишь $77,4 млрд, сократившись в годовом выражении почти вдвое и снизившись на 10,2% даже по сравнению с первым кварталом. Среди причин — геополитическая напряженность, устойчиво высокая инфляция, возможный дальнейший рост процентных ставок основных центробанков, а также общая неопределенность.', 1690579927, 'https://www.kommersant.ru/doc/6134852', -2524870687980624973);
INSERT INTO public."NewsRss" VALUES (65210, ' #468890', 'Реальная гееспособность запада сильно преувеличена.', 1645681549, 'http://bashorg.org/2022/02/24/468890.html', 5986381409087049656);
INSERT INTO public."NewsRss" VALUES (65213, 'Свидетели извинения // Следы детективного жанра в шорт-листе «Большой книги»', 'В длинном списке «Большой книги» было около десятка произведений с элементами детектива, те, где был совсем уже чистый жанр, совет экспертов отсеял, большая часть остальных перекочевала в короткий. О трех из них — «Волшебном хоре» Евгения Кремчукова, «Выше ноги от земли» Михаила Турбина и «Комитете охраны мостов» Дмитрия Захарова — рассказывает Михаил Пророков.', 1690579927, 'https://www.kommersant.ru/doc/6125245', -2818015741260962893);
INSERT INTO public."NewsRss" VALUES (65214, ' #468889', 'ххх: Ведь у меня совершенно не было: кашля, насморка, температуры, пониженной сатурации, трудностей с дыханием, потери вкуса. Какое-то время сильно поболело тело, не было сил вставать утром, зато была слабость, постоянная усталость и все время хотелось умереть. Но мой идеал –– Спарта, потому я говорила себе: &quot;Соберись, тряпка!&quot;, &quot;Это пройдет!&quot;, &quot;Все будет хорошо!&quot;, &quot;На тебе пахать можно!&quot;, &quot;Да раньше люди в поле рожали!&quot; и другие поддерживающие фразы нашего региона.', 1645681518, 'http://bashorg.org/2022/02/24/468889.html', 5986381409087847944);
INSERT INTO public."NewsRss" VALUES (65217, 'Чемпионка без чемпионата // Евгения Чикунова сохранила статус безусловного лидера брасса', 'Чемпионат мира, который проходит в японской Фукуоке, стал очень убедительным доказательством того, что из-за санкций в отношении отечественных спортсменов плавание лишилось явного лидера по крайней мере в одной из дисциплин. Золото первенства на дистанции 200 м брассом завоевала знаменитая южноафриканка Татьяна Cкунмакер. Но ее результат оказался на три с лишним секунды хуже, чем феноменальный мировой рекорд юной российской пловчихи Евгении Чикуновой.', 1690579927, 'https://www.kommersant.ru/doc/6134745', -2818018698607041613);
INSERT INTO public."NewsRss" VALUES (65218, ' #468888', 'xxx (японец): Единственное, что я получаю за уплату налогов – это то, что меня не сажают в тюрьму за неуплату налогов.', 1645681441, 'http://bashorg.org/2022/02/24/468888.html', 5986381409087868424);
INSERT INTO public."NewsRss" VALUES (65222, ' #468887', '(видео с пикабу)Меня достали заявления иностранцев, что дома в США строят из туалетной бумаги! Можете сами посмотреть и убедиться, что эти стены сделаны из картона.', 1645679581, 'http://bashorg.org/2022/02/24/468887.html', 5986381409087315464);
INSERT INTO public."NewsRss" VALUES (65221, 'Велика Африка, а отступать некуда — 2 // В Петербурге триумфально завершился еще один африканский день', '28 июля в Петербурге закончился форум Россия—Африка и начался саммит Африка—Россия. И то и другое происходило под председательством президента России Владимира Путина. Специальный корреспондент “Ъ” Андрей Колесников считает, что в Петербурге 28 июля было без преувеличения очень много Африки. Столько еще никогда не было. Но и в Африке было очень много Петербурга. Точнее, в африканских головах и душах, мятущихся в «Экспофоруме».', 1690574820, 'https://www.kommersant.ru/doc/6134843', -2502757310122794061);
INSERT INTO public."NewsRss" VALUES (65225, 'Пункты вверх // Фондовый рынок отыгрался на инфляции и нефти', 'Индекс Московской биржи превысил 3000 пунктов впервые после начала СВО. Эксперты связывают ралли с девальвацией рубля, ростом цен на нефть, дивидендной политикой компаний и внешним фоном. В дальнейшем рост может продолжиться: к концу года индекс Московской биржи может достичь 3500 пунктов, прогнозируют аналитики.', 1690574103, 'https://www.kommersant.ru/doc/6134873', -2502106399239150669);
INSERT INTO public."NewsRss" VALUES (65229, 'Украина поразила «Чехов сад» // ВСУ использовали зенитные ракеты для обстрелов Таганрога и Азова', 'В пятницу ВСУ нанесли удары по Таганрогу и Азову зенитными ракетами из комплексов С-200. По данным Минобороны России, обе ракеты были сбиты, однако боевая часть одной из них, содержащая около 37 тыс. поражающих элементов, упала и взорвалась в центре Таганрога. Полтора десятка человек получили ранения и травмы, повреждены многие здания, в том числе художественная галерея. МИД заявил об очередном «не имеющем никакого военного смысла теракте, организованном властями Украины» и возможности ответного удара, который Россия оставила за собой.', 1690573303, 'https://www.kommersant.ru/doc/6134868', -3308162771608247373);
INSERT INTO public."NewsRss" VALUES (65233, 'Сошлись в цене, но не в ценностях // Конгресс США ждет схватка по поводу оборонного бюджета', 'Американский Сенат принял проект оборонного бюджета на следующий финансовый год, начинающийся 1 октября 2023 года. За документ, предусматривающий повышение расходов на нужды Пентагона до рекордных $886 млрд, проголосовали 86 законодателей, против — 11. В ближайшие недели спецкомиссия попытается свести подготовленный Сенатом проект бюджета с вариантом Палаты представителей, содержащим множество идеологически окрашенных поправок. С необходимостью продолжения военной поддержки Украины согласны при этом в обеих палатах Конгресса.', 1690572017, 'https://www.kommersant.ru/doc/6134866', -2722694820050082893);
INSERT INTO public."NewsRss" VALUES (65237, 'За словом в запас не полезли // Сенаторы поддержали повышение призывного возраста', 'На последнем заседании весенней парламентской сессии в пятницу Совет федерации (СФ) принял ряд законов, уточняющих условия призыва граждан на военную службу. Сенаторы без возражений одобрили десятикратное увеличение штрафа за неявку в военкомат по повестке, запрет на выезд за границу после ее появления, повышение предельной планки призыва с 27 до 30 лет и другие инициативы. Валентина Матвиенко даже сказала, что тем самым сенаторы идут навстречу тем потенциальным призывникам, кто хотел бы послужить, но не успевал этого сделать из-за бытовых и семейных забот. Единственное, что волновало парламентариев: не заберут ли служить тех, кто уже вышел в запас? Обещания замминистра обороны оказалось достаточно, чтобы сенаторы поверили, что этого не случится.', 1690567352, 'https://www.kommersant.ru/doc/6134816', -2723803127770881101);
INSERT INTO public."NewsRss" VALUES (65240, 'Владимир Тарасенко перешел границу // Знаменитый российский форвард подписал контракт с «Оттавой»', 'Один из самых известных российских хоккеистов Владимир Тарасенко во второй раз за полгода поменял команду. Попав на финише прошлого регулярного чемпионата НХЛ из «Сент-Луис Блюз» в «Нью-Йорк Рейнджерс», которому помощь форварда не помогла конвертировать высочайший потенциал в хороший результат в Кубке Стэнли, Тарасенко в статусе свободного агента перешел в «Оттава Сенаторс». Этот клуб давно не пробивался в play-off, но на самом деле его состав отнюдь не так слаб, чтобы считать команду безнадежным аутсайдером.', 1690561419, 'https://www.kommersant.ru/doc/6125919', -3196681842150448205);
INSERT INTO public."NewsRss" VALUES (65234, ' #468884', 'джедай синего меча:Попросила мужа погулять с собакой (у него тоже тревожность и депрессивный период), чтобы он развеялся и отвлёкся, заодно мне помог (после тренировки плохо себя чувствую).А там прям перед нашей парадной труп, мужик выпал с общего балкона.Развеялся и отвлёкся, ага.', 1645677841, 'http://bashorg.org/2022/02/24/468884.html', 5986381409087131144);
INSERT INTO public."NewsRss" VALUES (65238, ' #468883', 'ххх: Интересные у тебя татуировки на ногах. Что они означают?ууу: Это варикоз.', 1645675981, 'http://bashorg.org/2022/02/24/468883.html', 5986381409086873096);
INSERT INTO public."NewsRss" VALUES (65242, ' #468882', 'Комментарии к видео &quot;Разрыв двух автосцепок при испытании&quot;ххх: На всякий случай отошёл от монитораууу: Я руку с телефоном убрал подальше от лицаeee: Я просто ладонью закрылся, и в щель между пальцев смотрелzzz: Я на всякий случай сохранил файл экселевский, с которым работалkkk: А я передернул на всякий случай. Вдруг это был последний', 1645602336, 'http://bashorg.org/2022/02/23/468882.html', 5986381409117974024);
INSERT INTO public."NewsRss" VALUES (65292, ' #468881', '14 февраля - день программистаДевопс: Ну вот собственно и вотДевопс: Писать разрабу, пусть пересобирает сервлет на glibc 2.17Заказчик: напишите ему сами и уточните, что конкретно нужно сделать, чтобы я не был испорченным телефоном.Девопс: Хорошо, написал.Заказчик: разработчик сегодня точно ничего не сделает. он даже текучку не выполнит сегодня по причине того, что жена требует праздника.. )', 1645602302, 'http://bashorg.org/2022/02/23/468881.html', 5986381409117830664);
INSERT INTO public."NewsRss" VALUES (65294, ' #468880', '- Виски из ячменя делают!- Короче – жидкая перловка...', 1645602241, 'http://bashorg.org/2022/02/23/468880.html', 5986381409117916680);
INSERT INTO public."NewsRss" VALUES (65298, ' #468879', 'Искусство - это прежде всего творческий подход к созданию глобальных проблем.', 1645600381, 'http://bashorg.org/2022/02/23/468879.html', 5986381409117665176);
INSERT INTO public."NewsRss" VALUES (65302, ' #468878', 'xxx: как застать северное сияние?yyy: пригнать шамана из Якутии и вместе с ним на ветру петь звуки и целовать снег. Если и не появится оно, зато будет забавно.', 1645598761, 'http://bashorg.org/2022/02/23/468878.html', 5986381409117554584);
INSERT INTO public."NewsRss" VALUES (65306, ' #468877', 'Играю. В бою один гад занялся целенаправленным уничтожением моих ЛИЧей. Ругаюсь уже в слух- Оставь в покое моих личинок!Из детской удивлённый голос:- Мааам! Ты что, симулятор рыбалки скачала?', 1645596781, 'http://bashorg.org/2022/02/23/468877.html', 5986381409118181272);
INSERT INTO public."NewsRss" VALUES (65309, ' #468876', 'с хабра, описание фильмов МатрицаСудя по всему, в городе машин либо очень либеральный мэр, либо очень криворукие сисадмины. Иначе как объяснить, что свободные люди беспрепятственно подключаются к вражеской ИТ-системе? Причем удаленно из тарантаса, летающего по канализации! Т.е. мало того, что у машин в сточных трубах развернут высокоскоростной Wi-Fi, так они еще и пускают в свою сеть всех подряд, позволяя неавторизованным пользователям получать данные из системы, вносить в нее изменения и общаться между собой. Красота!', 1645595119, 'http://bashorg.org/2022/02/23/468876.html', 5986381409118087064);
INSERT INTO public."NewsRss" VALUES (65313, ' #468875', 'Я мышей не боюсь, но однажды полезла в кухонный ящик за пакетом (у нормальных людей пакет с пакетами, а у меня целый ящик)), а оттуда внезапно выскочила мышка. Тогда я узнала, что у меня есть функция моментального вертикального взлета.', 1645595089, 'http://bashorg.org/2022/02/23/468875.html', 5986381409118238616);
INSERT INTO public."NewsRss" VALUES (65316, ' #468874', '- У меня лёд с лобового стекла не отчищается! Помоги, пожалуйста...- А давай ракелем попробуем?- Ладно. Только лёд потом отскреби...', 1645595041, 'http://bashorg.org/2022/02/23/468874.html', 5986381409118259096);
INSERT INTO public."NewsRss" VALUES (65319, ' #468873', 'yyy: все мои мечты сбываются, причём быстроНо мясом наружуКогда я загадал желание на Новый год летать куда-нибудь почаще, через десять минут позвонили и сказали, что воры проникли в мою квартиру. Пришлось тут же лететь домойВообщем, стараюсь не мечтать', 1645593190, 'http://bashorg.org/2022/02/23/468873.html', 5986381409118001048);
INSERT INTO public."NewsRss" VALUES (65321, 'Атомики в Go: особенности внутренней реализации', 'Атомики в Go - это один из методов синхронизации горутин. Они находятся в пакете стандартной библиотеки sync/atomic. Некоторые статьи сравнивают atomics с mutex, так как это примитивы синхронизации низкого уровня. Они предоставляют бенчмарки и  сравнения по скорости, например Go: How to Reduce Lock Contention with the Atomic Package. Однако важно понимать, что, хотя это примитивы синхронизации низкого уровня, они разные по своей сути. Прежде всего атомики являются "low-level atomic memory primitives", как отмечено в документации, то есть являются примитивами низкого уровня реализующих атомарные операции с памятью. В этой статье я расскажу про некоторые особенности их внутренней реализации и отличие от мьютексов. Читать далее', 1688137810, 'https://habr.com/ru/articles/744822/?utm_campaign=744822&utm_source=habrahabr&utm_medium=rss', -1039153105148129372);
INSERT INTO public."NewsRss" VALUES (65322, ' #468872', '- В репчатом луке и красном перце витамина С в разы так поболее, чем в апельсинах.- Я бы удивилась получить сетку лука в больнице?', 1645593121, 'http://bashorg.org/2022/02/23/468872.html', 5986381409117972376);
INSERT INTO public."NewsRss" VALUES (65324, '[Перевод] Эффективная работа с битами при помощи Go', '
Это статья познакомит вас с использованием возможностей Go для выполнения манипуляций с битами. Здесь мы разберём установку, очистку, инвертирование, сдвиг битов, использование техники SWAR, эффективную обработку Юникода и прочие приёмы, позволяющие повысить продуктивность программирования. Читать дальше &rarr;', 1688130001, 'https://habr.com/ru/companies/ruvds/articles/744230/?utm_campaign=744230&utm_source=habrahabr&utm_medium=rss', -674049743043871654);
INSERT INTO public."NewsRss" VALUES (65325, ' #468871', 'Вспомнила диалог из аудиокурса испанского для англоязычных (урок то ли 2, то ли 3):- добрый день!- добрый день!- у вас есть песо?- нет, у меня нет песо.- у вас есть доллары?- нет, у меня нет долларов.- до свидания.Забыла уточнить, первый голос - женский, второй - мужской ))', 1645591561, 'http://bashorg.org/2022/02/23/468871.html', 5986381409117829016);
INSERT INTO public."NewsRss" VALUES (65327, ' #468870', 'Картинк:У сотрудника на работе кошка - Корниш-рекс (постирали, высушили, расчесать забыли) и уже полвека дома кактус с кубы (дядька служил инженером по разверныванию ракетных установок во времена острой напряженности), кактус собственно и был подарком с кубы. Здоровый, сука, аш под потолок, в кадке на центнер земли. Повадилась кошка ссать в этот кактус, от чего у него корни стали немного подгнивать. А еще в той-же комнате на полу лежал большой такой ковер, на котором эта кошка и спала под лучами солнышка. Вот в один теплый день, кактусу все это надоело и он пизданулся прямо на спящую кошку - животину пришлось срочно везти зашивать + переломалась немного. Со слов сотрудника, кактус сантиметров на 30 снизу изнутри весь сгнил, но теперь живет отростками сразу в нескольких горшках. Кошка имеет свойство шипеть проходя рябом с горшками.Мораль: не спи под деревом, на которое ссышь.', 1645589572, 'http://bashorg.org/2022/02/23/468870.html', 5986381409117915032);
INSERT INTO public."NewsRss" VALUES (65328, ' #468869', '- У меня на одном курсе был фин, он приехал к нам т.к. был очарован культурой гопников. Он хотел проникнуться ею у первоисточника и подтянуть мат. И вот где-то в Питере он припал к истокам, все-все выучил и загорелся желанием принести культуру другим иностранцам группы. А там были бразильцы, немцы итальянцы, французы и китаец. И вот захожу как-то я в группу и там хором повторяют слова &quot;ъуъ&quot; и &quot;съка&quot; с шестью разными акцентами.- Хотелось бы послушать, как они говорили &quot;ъуъ&quot;', 1645589517, 'http://bashorg.org/2022/02/23/468869.html', 5986381409117664808);
INSERT INTO public."NewsRss" VALUES (65329, ' #468868', 'Поехали мы на международную олимпиаду в Гонконг. Первый день, все подходят друг к другу и знакомятся (по-английски). В 9 из 10 случаев диалог с членами нашей команды начинался так:-привет, ты откуда?-привет, из России-о, а научи ругаться по-русски!В 10-м случае так:-привет, ты откуда?-привет, из России-о, а я знаю, как ругаться по-русски!', 1645589461, 'http://bashorg.org/2022/02/23/468868.html', 5986381409117554216);
INSERT INTO public."NewsRss" VALUES (65330, ' #468867', 'С ямаркета отзыв на усилитель для наушников:xxx: Не сказал бы, что разница небо и земля, но лучше. И это я еще уши не надел. Потом надел и вообще хорошо стало.yyy: а если уши ещё и подключить - то вообще бомба!!', 1645512274, 'http://bashorg.org/2022/02/22/468867.html', 5986381409130436136);
INSERT INTO public."NewsRss" VALUES (65331, ' #468866', 'Всё-таки Паркинсон гуманнее Альцгеймера. Куда лучше расплескать полстакана коньяка, чем начисто забыть, куда спрятал бутылку.', 1645512242, 'http://bashorg.org/2022/02/22/468866.html', 5986381409130473000);
INSERT INTO public."NewsRss" VALUES (65332, ' #468865', '- Мы так привыкли к бантикам на нижнем белье, что не задумываемся, зачем они вообще нужны. Однако раньше они были полезной частью декора, которая появилась во времена Ренессанса. Давным-давно никаких резинок в белье не было и панталоны завязывали спереди с помощью тесемок на бантик. Отголосок этой традиции и сохранился до сих пор.- Ненавижу эти дурацкие бантики и сразу их отрезаю при покупке белья. Видно мои предки ходили без трусов или они у них все время спадали))))', 1645510390, 'http://bashorg.org/2022/02/22/468865.html', 5986381409130624552);
INSERT INTO public."NewsRss" VALUES (65333, ' #468864', 'ххх: Хотел быть похожим на героя индийских боевиков, а получился похожим на героя афганских боевиков. Вроде бы и регион тот же, а отношение совсем разное...', 1645510337, 'http://bashorg.org/2022/02/22/468864.html', 5986381409130513960);
INSERT INTO public."NewsRss" VALUES (65334, ' #468863', 'В одном из АС заглючила игра на миссии отнести посылку Леонардо да Винчи, так Эцио у меня ее через пол Венеции допинал, но доставил. Не знаю разбилось там по дороге что-либо, но заказчик претензий не предъявлял.', 1645510261, 'http://bashorg.org/2022/02/22/468863.html', 5986381409130780200);
INSERT INTO public."NewsRss" VALUES (65335, ' #468862', '...такие игры были ещё на прадендюшке современных игровых приставок...', 1645508739, 'http://bashorg.org/2022/02/22/468862.html', 5986381409130882600);
INSERT INTO public."NewsRss" VALUES (65336, ' #468861', 'Жена сказала, что купила жидкость для мытья мужа. Оказалось &quot;2 в 1 мужской шампунь-гель для душа&quot;', 1645508701, 'http://bashorg.org/2022/02/22/468861.html', 5986381409130739240);
INSERT INTO public."NewsRss" VALUES (67287, 'У России самые большие суточные потери танков за полтора месяца - Liga.net', '', 1690694400, 'https://news.google.com/atom/articles/CBMiYWh0dHBzOi8vbmV3cy5saWdhLm5ldC9hbGwvbmV3cy91LXJvc3NpaS1zYW15ZS1ib2xzaGllLXN1dG9jaG55ZS1wb3RlcmktdGFua292LXphLXBvbHRvcmEtbWVzeWF0c2HSAWVodHRwczovL25ld3MubGlnYS5uZXQvYW1wL2FsbC9uZXdzL3Utcm9zc2lpLXNhbXllLWJvbHNoaWUtc3V0b2NobnllLXBvdGVyaS10YW5rb3YtemEtcG9sdG9yYS1tZXN5YXRzYQ?oc=5', -1781231653462914473);
INSERT INTO public."NewsRss" VALUES (68087, 'Аэропорт «Внуково» закрыт на вылет и прилет - BFM.RU', '', 1690681730, 'https://news.google.com/atom/articles/CBMiHmh0dHBzOi8vd3d3LmJmbS5ydS9uZXdzLzUzMDY3NdIBImh0dHBzOi8vd3d3LmJmbS5ydS9hbXAvbmV3cy81MzA2NzU?oc=5', 716883780745242855);
INSERT INTO public."NewsRss" VALUES (65953, 'Luceat Lux Vestra: роль солнечного света в регулировании циркадных ритмов', 'Важность сна в поддержании здорового жизненного цикла животных (в том числе вида Homo Sapiens) сложно переоценить. Причем, речь идет не только о физиологическом здоровье, но и о высших нервных функциях, например, таких как способность к обучению. Так, группа ученых из университетов Цюриха (Швейцария) и Леувена (Бельгия) в 2017 году показала [1], что во время фазы глубокого сна происходят процессы, важные для достижения определенного уровня нейропластичности, что в свою очередь является необходимым условием успешного обучения.Циклы сна и бодрствования регулируются двумя основными факторами. Читать далее', 1690661102, 'https://habr.com/ru/articles/751260/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751260', -1038280859052441692);
INSERT INTO public."NewsRss" VALUES (66359, 'Потерянное искусство: художники золотого века игровых обложек', '

30 лет назад к покупке игры мотивировала информация в прессе, реклама в телевизоре или коробка на прилавке с красивой обложкой. Цепляющий рисунок заставлял посетителя магазина взять коробку в руки, прочесть аннотацию и посмотреть на скриншоты. В наши дни это кажется чем-то очень далеким, так как все привыкли читать отзывы, играть в демоверсии, смотреть трейлеры или стримы.

Над оформлением обложек часто работали известные художники, талантливые иллюстраторы и комиксисты. Свои картины они рисовали на основе внутриигровой графики и геймплея. Цель была проста: изобразить дух игры на её обложке.

Подробно рассказываем о феномене и вспоминаем значимых художников, которые подарили свои рисунки хорошим играм. Читать дальше &rarr;', 1690704061, 'https://habr.com/ru/companies/timeweb/articles/751150/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751150', -314038360333510245);
INSERT INTO public."NewsRss" VALUES (66365, '13 вопросов для собеседования, на которые должен знать ответы каждый продакт', 'Кому будет полезна статья?Middle и junior продактам&nbsp;— позволит найти свои зоны роста, а&nbsp;также подготовиться к&nbsp;собеседованиям в&nbsp;топовые IT компании.Тем, кто хочет стать менеджером продукта, но&nbsp;не&nbsp;знает какие компетенции стоит прокачать, чтобы войти в&nbsp;профессию.Нанимающим менеджерам&nbsp;— поможет составить требования к&nbsp;вакансии продакта и провести интервью. Читать далее', 1690697685, 'https://habr.com/ru/articles/751280/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751280', -1038289517706510428);
INSERT INTO public."NewsRss" VALUES (66383, 'Стоимостной анализ процессов для оценки эффекта от новой функциональности', 'Привет!В статье расскажу, как измерить влияние личного кабинета для юридических лиц на процессы клиентского сервиса и оценить эффект от разработки новой функциональности на сайте. Читать далее', 1690631731, 'https://habr.com/ru/articles/751232/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751232', -1039154489760186460);
INSERT INTO public."NewsRss" VALUES (66387, 'От джуна до профи: прокачиваем нужные компетенции', 'Все круги ада ступени собеседований пройдены, заветный оффер прилетел на почту, и специалистка, не стряхнув эйфорию, окунается в трудовые будни не замечая, как её начинает засасывать трясина. Проходит месяц, другой, задачи наваливаются как из «рога изобилия», важно разобраться что с ними делать, «разгрести завалы».&nbsp;Вот такая картина рисуется после изучения десятков кейсов от джунов молодых специалистов. «Замкнутый круг», из которого попытаемся выбраться. Сообществу LivreLady рассказывают читательницы:&nbsp;«Недавно я устроилась джуном на работу-мечты. Меня взяли в довольно известную в России веб-студию. Я в течение полугода слала сюда резюме, напрашивалась на собес и вот мечта сбылась. Но оказаться в IT-среде не имея никакого профильного бэкграунда - то еще испытание. Словно попадаешь на другую планету. Ничего не понимаешь. Все менеджеры с опытом, у всех десятки проектов за плечами, а я, ощущая себя полной дурой, в очередной раз спрашиваю “А это задача на бэк или на фронт?” Ощущение того, что я ниже плинтуса не покидает. Кажется, что я тупо мешаюсь под ногами и программисты быстрее все сделают, если я лезть не буду. Но я же менеджер проекта, а значит именно я должна говорить им, что делать. Вот как быть? Все чаще думаю, что я не на своем месте. Может уволиться? Но мне нравится студия и то, что в ней происходит, какие проекты делают. Хочу быть частью этого».&nbsp; Читать далее', 1690704052, 'https://habr.com/ru/articles/751298/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751298', -1037304973763313756);
INSERT INTO public."NewsRss" VALUES (66392, 'Аналитики с диапазонами дат в MS SQL', 'Развернув очередной обратно разработчику Pull Request с поиском по аналитике, принимающей разные значения в разные промежутки времени, я решил на планерке обсудить этот вопрос. И был удивлен, что подавляющее большинство разработчиков не понимают, как эффективно искать на SQL в таких случаях. Погуглив, ради интереса, обнаружил, что этот вопрос как-то обходится стороной сообществом. В итоге решил написать статью, заодно ссылаясь на нее самому.Сразу хочу уточнить, что речь идет именно об MS SQL, так как, например, в PostgreSQL уже есть диапазонные типы и виды индексов, позволяющие их индексировать. Читать далее', 1690634126, 'https://habr.com/ru/articles/751238/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751238', -1037289718039478364);
INSERT INTO public."NewsRss" VALUES (67289, 'Путин заявил о готовности России к столкновению с НАТО - Ведомости', '', 1690695489, 'https://news.google.com/atom/articles/CBMiaWh0dHBzOi8vd3d3LnZlZG9tb3N0aS5ydS9wb2xpdGljcy9uZXdzLzIwMjMvMDcvMzAvOTg3NTc3LXB1dGluLW8tZ290b3Zub3N0aS1yb3NzaWktay1zdG9sa25vdmVuaXl1LXMtbmF0b9IBAA?oc=5', 5498609234380949790);
INSERT INTO public."NewsRss" VALUES (66395, 'Тестирование собственного NAS. Часть 2. База', 'В предыдущей статье мы формулировали цели и составляли список тестов для автоматизации. Далее в работе QA обычно следует разработка базовых тестов и обвязки для них, чем мы в этой статье и займёмся. Полный код проекта лежит на гитхаб и приводить его в статье мы не будем. Дисклеймер! Это не новость, не туториал и не энциклопедическая заметка, не аккуратная статья со схемами, графиками и выверенной структурой. Дело в том, что проект NAS мы делаем по фану и в свободное от основной работы время. Как следствие, ресурсов на разработку не много, а энтузиазм и внутренняя дисциплина не всесильны. Ответственность перед аудиторией Хабра подталкивает что-то делать, перепроверять свои идеи, избегать халтуры, проводить ревью результатов работы, да и просто глубже вникать в суть. По этим причинам мы попробуем вести на Хабре дневник разработки. Может кто-то почерпнёт тут идеи для своих проектов, а мы в свою очередь сумеем раньше прислушаться к мнению аудитории и улучшим свои решения. Читать далее', 1690622866, 'https://habr.com/ru/companies/3rdman/articles/751004/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751004', 5478217001415861796);
INSERT INTO public."NewsRss" VALUES (67106, 'Черная сторона науки', 'Некоторые исследователи срезают углы, искажают данные и изображения, фальсифицируют результаты и цитирования, чтобы реализовать научные работы и получить причитающееся за них вознаграждение. Ученым уже недостаточно просто опубликовать свою работу. Необходимо, чтобы она имела авторитет на длительный срок. Стремление к этому влиянию ставит научную работу в центр целой сети показателей - как правило, это место публикации и количество цитирований - высокие результаты по этим показателям становятся целью, ради которой ученые и издатели готовы идти на обман. Читать далее', 1690707601, 'https://habr.com/ru/articles/750582/?utm_source=habrahabr&utm_medium=rss&utm_campaign=750582', -1039169143927504988);
INSERT INTO public."NewsRss" VALUES (67192, 'Экспресс создание Telegram бота на C#', 'В данном материале рассматривается реализация телеграм-бота с помощью фреймворка SKitLs.Bots.Telegram, позволяющего абстрагироваться от однообразной if-else архитектуры и качественно перейти на новый, нелинейный, уровень архитектуры реализации ботов.В качестве фундамента материала взята идея написание простого бота для отображения текущей погоды в указанном городе с помощью API сервисов Яндекса "Геокодер" и "Погода". Читать далее', 1690707657, 'https://habr.com/ru/articles/751302/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751302', -1039156483967189084);
INSERT INTO public."NewsRss" VALUES (67206, 'Мера освобождения // У следствия и прокуратуры не нашлось аргументов для продолжения содержания банкиров в «Матросской Тишине»', 'Как стало известно “Ъ”, из СИЗО освобождены бывшие банкиры Кирилл Любенцов и Александр Лукин, обвиняемые в хищении $40 млн и 8,1 млрд руб. при санации Бинбанком Рост-банка. Арестовали их еще в августе прошлого года, а сейчас следствие и прокуратура настаивали на продлении нахождения под стражей до конца октября. Судья же счел, что данная мера пресечения ничем не мотивирована, вернув финансистов домой.', 1690710881, 'https://www.kommersant.ru/doc/6135444', -2786496453737028685);
INSERT INTO public."NewsRss" VALUES (67233, '[Перевод] Всё-таки схождение к нормальному распределению происходит медленно', '
Многие реальные данные при использовании центральной предельной теоремы (ЦПТ) не сходятся быстро, поэтому не стоит применять её слепо. В этой статье мы разберём наглядные примеры этого и познакомимся с альтернативами для ЦПТ. Читать дальше &rarr;', 1690711201, 'https://habr.com/ru/companies/ruvds/articles/750688/?utm_source=habrahabr&utm_medium=rss&utm_campaign=750688', -673072628232319910);
INSERT INTO public."NewsRss" VALUES (67239, 'Хочешь «вайти» — входи', 'Я, как обычно, выступаю в роли попугая-пересмешника и отвечаю на статью длинным постом вместо короткого комментария. Дурацкий опрос в комплекте. Читать далее', 1690702378, 'https://habr.com/ru/articles/751290/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751290', -1038290136181801052);
INSERT INTO public."NewsRss" VALUES (67277, 'Ракетный удар РФ по учебному заведению в Сумах: возросло количество погибших и раненых - Украинская правда', '', 1690706636, 'https://news.google.com/atom/articles/CBMiNmh0dHBzOi8vd3d3LnByYXZkYS5jb20udWEvcnVzL25ld3MvMjAyMy8wNy8zMC83NDEzNDUwL9IBP2h0dHBzOi8vd3d3LnByYXZkYS5jb20udWEvcnVzL25ld3MvMjAyMy8wNy8zMC83NDEzNDUwL2luZGV4LmFtcA?oc=5', -3499441555495775845);
INSERT INTO public."NewsRss" VALUES (67279, 'Более 3 тыс. военных участвуют в Главном военно-морском параде в Петербурге - Интерфакс', '', 1690707840, 'https://news.google.com/atom/articles/CBMiJWh0dHBzOi8vd3d3LmludGVyZmF4LnJ1L3J1c3NpYS85MTQwMTLSASJodHRwczovL3d3dy5pbnRlcmZheC5ydS9hbXAvOTE0MDEy?oc=5', -140870992992453095);
INSERT INTO public."NewsRss" VALUES (67281, 'Как выглядит Москва-Сити после атаки дронов. Из-за взрывов в двух небоскребах выбило окна Фотографии — Meduza - Meduza', '', 1690702740, 'https://news.google.com/atom/articles/CBMifmh0dHBzOi8vbWVkdXphLmlvL2ZlYXR1cmUvMjAyMy8wNy8zMC9rYWstdnlnbHlhZGl0LW1vc2t2YS1zaXRpLXBvc2xlLWF0YWtpLWRyb25vdi1pei16YS12enJ5dm92LXYtZHZ1aC1uZWJvc2tyZWJhaC12eWJpbG8tb2tuYdIBAA?oc=5', 5181912014556198776);
INSERT INTO public."NewsRss" VALUES (67283, 'На трассе в Казахстане заметили тралы с военной техникой. Ее везли в Россию – фото - Liga.net', '', 1690703820, 'https://news.google.com/atom/articles/CBMidGh0dHBzOi8vbmV3cy5saWdhLm5ldC9wb2xpdGljcy9uZXdzL25hLXRyYXNzZS12LWthemFoc3RhbmUtemFtZXRpbGktdHJhbHktcy12b2Vubm95LXRlaG5pa295LWVlLXZlemxpLXYtcm9zc2l5dS1mb3Rv0gF4aHR0cHM6Ly9uZXdzLmxpZ2EubmV0L2FtcC9wb2xpdGljcy9uZXdzL25hLXRyYXNzZS12LWthemFoc3RhbmUtemFtZXRpbGktdHJhbHktcy12b2Vubm95LXRlaG5pa295LWVlLXZlemxpLXYtcm9zc2l5dS1mb3Rv?oc=5', 8657656291069132109);
INSERT INTO public."NewsRss" VALUES (67285, 'Семь человек погибли при урагане в Марий Эл - BFM.RU', '', 1690679137, 'https://news.google.com/atom/articles/CBMiHmh0dHBzOi8vd3d3LmJmbS5ydS9uZXdzLzUzMDY3MtIBImh0dHBzOi8vd3d3LmJmbS5ydS9hbXAvbmV3cy81MzA2NzI?oc=5', -179596084820172335);
INSERT INTO public."NewsRss" VALUES (67292, 'Как изменилась жизнь в Таганроге после мощного взрыва 28 июля - RostovGazeta', '', 1690637820, 'https://news.google.com/atom/articles/CBMidWh0dHBzOi8vcm9zdG92Z2F6ZXRhLnJ1L25ld3MvMjAyMy0wNy0yOS9rYWstaXptZW5pbGFzLXpoaXpuLXYtdGFnYW5yb2dlLXBvc2xlLW1vc2Nobm9nby12enJ5dmEtZG5lbS0yOC1peXVseWEtMjk5ODA5NdIBAA?oc=5', -6711742454339230840);
INSERT INTO public."NewsRss" VALUES (67294, 'Вениамин Кондратьев и командир Новороссийской Военно-Морской базы обошли парадные линии - Телеканал «Краснодар»', '', 1690703160, 'https://news.google.com/atom/articles/CBMihgFodHRwczovL3R2a3Jhc25vZGFyLnJ1L29ic2hjaGVzdHZvLzIwMjMvMDcvMzAvdmVuaWFtaW4ta29uZHJhdGV2LWkta29tYW5kaXItbm92b3Jvc3NpeXNrb3ktdm9lbm5vLW1vcnNrb3ktYmF6eS1vYm9zaGxpLXBhcmFkbnllLWxpbmlpL9IBigFodHRwczovL3R2a3Jhc25vZGFyLnJ1L2FtcC9vYnNoY2hlc3R2by8yMDIzLzA3LzMwL3ZlbmlhbWluLWtvbmRyYXRldi1pLWtvbWFuZGlyLW5vdm9yb3NzaXlza295LXZvZW5uby1tb3Jza295LWJhenktb2Jvc2hsaS1wYXJhZG55ZS1saW5paS8?oc=5', -3389646065958972452);
INSERT INTO public."NewsRss" VALUES (67295, 'ВСУ ударили по Брянской области, есть пострадавшие - URA.RU', '', 1690707960, 'https://news.google.com/atom/articles/CBMiIGh0dHBzOi8vdXJhLm5ld3MvbmV3cy8xMDUyNjcxMzEw0gEkaHR0cHM6Ly9hbXAudXJhLm5ld3MvbmV3cy8xMDUyNjcxMzEw?oc=5', -2198820982666479661);
INSERT INTO public."NewsRss" VALUES (67296, 'В Киеве переименуют советский монумент «Родина-мать» - BFM.RU', '', 1690687887, 'https://news.google.com/atom/articles/CBMiHmh0dHBzOi8vd3d3LmJmbS5ydS9uZXdzLzUzMDY2N9IBAA?oc=5', -5568918062452848069);
INSERT INTO public."NewsRss" VALUES (67297, 'Mash: режим «Ковер» введен в аэропорту Внуково - URA.RU', '', 1690683300, 'https://news.google.com/atom/articles/CBMiIGh0dHBzOi8vdXJhLm5ld3MvbmV3cy8xMDUyNjcxMjY50gEkaHR0cHM6Ly9hbXAudXJhLm5ld3MvbmV3cy8xMDUyNjcxMjY5?oc=5', 468080095345879727);
INSERT INTO public."NewsRss" VALUES (67298, 'Владимира Путина спросили, не 37-й ли сейчас в России год — Новости — город Рязань на городском сайте RZN.info - Новости — РЗН.ИНФО', '', 1690700299, 'https://news.google.com/atom/articles/CBMiaWh0dHBzOi8vd3d3LnJ6bi5pbmZvL25ld3MvMjAyMy83LzMwL3ZsYWRpbWlyYS1wdXRpbmEtc3Byb3NpbGktbmUtMzctai1saS1zZWpjaGFzLXYtcm9zc2lpLWdvZC0yNzI1OTYuaHRtbNIBAA?oc=5', -5414692161734529441);
INSERT INTO public."NewsRss" VALUES (67299, 'Самолёт с отказавшим шасси из Улан-Удэ приземлился в аэропорту Шереметьево - Редакция газеты Номер один', '', 1690699189, 'https://news.google.com/atom/articles/CBMiKWh0dHBzOi8vZ2F6ZXRhLW4xLnJ1L25ld3Mvc29jaWV0eS8xMjQ0OTQv0gEA?oc=5', -7847112731120911769);
INSERT INTO public."NewsRss" VALUES (67300, 'Повышение ставок ФРС и ЕЦБ и рост основных валют на Мосбирже. Как завершилась неделя на мировых рынках - BFM.RU', '', 1690567701, 'https://news.google.com/atom/articles/CBMiHmh0dHBzOi8vd3d3LmJmbS5ydS9uZXdzLzUzMDYwONIBImh0dHBzOi8vd3d3LmJmbS5ydS9hbXAvbmV3cy81MzA2MDg?oc=5', -1823302612604895127);
INSERT INTO public."NewsRss" VALUES (67301, 'Акции Polymetal выросли на 38% на новости о делистинге с Лондонской биржи От Investing.com - Investing.com Россия', '', 1690557300, 'https://news.google.com/atom/articles/CBMiP2h0dHBzOi8vcnUuaW52ZXN0aW5nLmNvbS9uZXdzL3N0b2NrLW1hcmtldC1uZXdzL2FydGljbGUtMjI3OTE1OdIBAA?oc=5', -2454596763425885805);
INSERT INTO public."NewsRss" VALUES (67302, 'В РФ стали выпускать УАЗ «Патриот» с двигателем Toyota V8 и 6-японской 6АКПП - SPEEDME.RU', '', 1690695291, 'https://news.google.com/atom/articles/CBMiNmh0dHBzOi8vc3BlZWRtZS5ydS9wb3N0cy9pZC01NzI1MS1vMnlPQzlaMGhOUnJWd3M2U016ZNIBOWh0dHBzOi8vc3BlZWRtZS5ydS9hbXBwb3N0cy9pZC01NzI1MS1vMnlPQzlaMGhOUnJWd3M2U016ZA?oc=5', -1506833472703363906);
INSERT INTO public."NewsRss" VALUES (67303, 'Lada Iskra 2024 года сфотографировали на испытаниях - Наавтотрассе.ру', '', 1690692690, 'https://news.google.com/atom/articles/CBMiTmh0dHBzOi8vbmFhdnRvdHJhc3NlLnJ1L3Zhei9hdnRvdmF6LWdvdG92aXQtc292ZXJzaGVubm8tbm92dXl1LWxhZGEtaXNrcmEuaHRtbNIBAA?oc=5', 8976020802150465472);
INSERT INTO public."NewsRss" VALUES (67304, 'Издательский директор Larian Studios рассказал о Baldurʼs Gate 3 на Steam Deck - Канобу', '', 1690706439, 'https://news.google.com/atom/articles/CBMia2h0dHBzOi8va2Fub2J1LnJ1L25ld3MvaXpkYXRlbHNraWotZGlyZWt0b3ItbGFyaWFuLXN0dWRpb3MtcmFzc2themFsLW8tYmFsZHVycy1nYXRlLTMtbmEtc3RlYW0tZGVjay00NzI2NDIv0gEA?oc=5', -3008667323464438172);
INSERT INTO public."NewsRss" VALUES (67305, 'Отечественный процессор Baikal-S сравнили с Intel Xeon 6230 и Huawei Kunpeng 920 - Goha.ru', '', 1690697001, 'https://news.google.com/atom/articles/CBMibGh0dHBzOi8vd3d3LmdvaGEucnUvb3RlY2hlc3R2ZW5ueWotcHJvY2Vzc29yLWJhaWthbC1zLXNyYXZuaWxpLXMtaW50ZWwteGVvbi02MjMwLWktaHVhd2VpLWt1bnBlbmctOTIwLWQyM3JlMdIBAA?oc=5', 8128740379956016428);
INSERT INTO public."NewsRss" VALUES (67306, 'Sapphire представила яркую видеокарту Radeon RX 7600 в стиле игры Party Animals - 3DNews', '', 1690630200, 'https://news.google.com/atom/articles/CBMiY2h0dHBzOi8vM2RuZXdzLnJ1LzEwOTA3NTcvc2FwcGhpcmUtcHJlZHN0YXZpbGEtdmlkZW9rYXJ0dS1yYWRlb24tcngtNzYwMC12LXN0aWxlLWlncmktcGFydHktYW5pbWFsc9IBZ2h0dHBzOi8vM2RuZXdzLnJ1LzEwOTA3NTcvc2FwcGhpcmUtcHJlZHN0YXZpbGEtdmlkZW9rYXJ0dS1yYWRlb24tcngtNzYwMC12LXN0aWxlLWlncmktcGFydHktYW5pbWFscy9hbXA?oc=5', 2157285883361133677);
INSERT INTO public."NewsRss" VALUES (67307, 'Poco представила ультрабюджетные TWS-наушники с 12-мм драйверами - Rozetked', '', 1690700098, 'https://news.google.com/atom/articles/CBMiYmh0dHBzOi8vcm96ZXRrZWQubWUvbmV3cy8yOTg5Mi1wb2NvLXByZWRzdGF2aWxhLXVsLXRyYWJ5dWR6aGV0bnllLXR3cy1uYXVzaG5pa2ktcy0xMi1tbS1kcmF5dmVyYW1p0gEA?oc=5', 1222439764698889434);
INSERT INTO public."NewsRss" VALUES (67308, 'Умер муж певицы Натали, продюсер Александр Рудин - StarHit.ru', '', 1690704660, 'https://news.google.com/atom/articles/CBMiWGh0dHBzOi8vd3d3LnN0YXJoaXQucnUvbm92b3N0aS91bWVyLW11emgtcGV2aWN5LW5hdGFsaS1wcm9keXVzZXItYWxla3NhbmRyLXJ1ZGluLTg5OTkyNi_SAQA?oc=5', -5526026440306189068);
INSERT INTO public."NewsRss" VALUES (67309, 'Водолеям будет сопутствовать успех , а Девам придется отвечать на вызовы судьбы - Живая Кубань - Новости Краснодара и Краснодарского Края', '', 1690696811, 'https://news.google.com/atom/articles/CBMidmh0dHBzOi8vd3d3LmxpdmVrdWJhbi5ydS9uZXdzL29ic2hjaGVzdHZvL3ZvZG9sZXlhbS1idWRldC1zb3B1dHN0dm92YXQtdXNwZWtoLWRldmFtLXByaWRldHN5YS1vdHZlY2hhdC1uYS12eXpvdnktc3VkYnnSAQA?oc=5', 5252406060226076912);
INSERT INTO public."NewsRss" VALUES (67310, 'Директор «Ленкома» прокомментировал уход из театра вдовы Караченцова - Информационный портал Altapress.ru', '', 1690631040, 'https://news.google.com/atom/articles/CBMibGh0dHBzOi8vYWx0YXByZXNzLnJ1L3poaXpuL3N0b3J5L2RpcmVrdG9yLWxlbmtvbWEtcHJva29tbWVudGlyb3ZhbC11aG9kLWl6LXRlYXRyYS12ZG92aS1rYXJhY2hlbnRzb3ZhLTMyOTI3MNIBAA?oc=5', 8353932007974605367);
INSERT INTO public."NewsRss" VALUES (67311, 'Бежавшая из России Пугачева приехала в Юрмалу на фестиваль собирать деньги для ВСУ - Подмосковье Сегодня', '', 1690671480, 'https://news.google.com/atom/articles/CBMidmh0dHBzOi8vbW9zcmVndG9kYXkucnUvbmV3cy9zb2MvYmV6aGF2c2hhamEtaXotcm9zc2lpLXB1Z2FjaGV2YS1wcmllaGFsYS12LWp1cm1hbHUtbmEtZmVzdGl2YWwtc29iaXJhdC1kZW5naS1kbGphLXZzdS_SAQA?oc=5', 1730299454716515319);
INSERT INTO public."NewsRss" VALUES (67312, 'Джастин Гэтжи нокаутировал Дастина Порье ударом ногой в голову - allboxing.ru', '', 1690691577, 'https://news.google.com/atom/articles/CBMiZ2h0dHBzOi8vYWxsYm94aW5nLnJ1L25ld3MvMjAyMzA3MzAtMDczMi9kemhhc3Rpbi1nZXR6aGktbm9rYXV0aXJvdmFsLWRhc3RpbmEtcG9yZS11ZGFyb20tbm9nb3ktdi1nb2xvdnXSAQA?oc=5', -4041136717755645176);
INSERT INTO public."NewsRss" VALUES (67313, 'Экс-арбитр РПЛ Федотов — об удалении Семака: «Зенит» спокойно может обращаться в КДК» - Sport24.ru - новости спорта онлайн в России и мире', '', 1690685880, 'https://news.google.com/atom/articles/CBMie2h0dHBzOi8vc3BvcnQyNC5ydS9mb290YmFsbC9uZXdzLTU2MzI0MC1la3MtYXJiaXRyLXJwbC1mZWRvdG92LW9iLXVkYWxlbmlpLXNlbWFrYS16ZW5pdC1zcG9rb3luby1tb3poZXQtb2JyYXNoY2hhdHN5YS12LWtka9IBf2h0dHBzOi8vYW1wLnNwb3J0MjQucnUvZm9vdGJhbGwvbmV3cy01NjMyNDAtZWtzLWFyYml0ci1ycGwtZmVkb3Rvdi1vYi11ZGFsZW5paS1zZW1ha2EtemVuaXQtc3Bva295bm8tbW96aGV0LW9icmFzaGNoYXRzeWEtdi1rZGs?oc=5', 1891145013426455513);
INSERT INTO public."NewsRss" VALUES (67314, 'Лыжный спорт без России загибается на глазах. Денег нет даже на чемпионат мира - news.Sportbox.ru', '', 1690703409, 'https://news.google.com/atom/articles/CBMilgFodHRwczovL25ld3Muc3BvcnRib3gucnUvVmlkeV9zcG9ydGEvY3Jvc3NfY291bnRyeS9zcGJuZXdzX05JMTkyMzY2N19MeXpobnlqX3Nwb3J0X2Jlel9Sb3NzaWlfemFnaWJhamV0c2FfbmFfZ2xhemFoX0RlbmVnX25ldF9kYXpoZV9uYV9jaGVtcGlvbmF0X21pcmHSAQA?oc=5', 3877920835508994104);
INSERT INTO public."NewsRss" VALUES (67315, 'Копылов в третий раз подряд победил нокаутом на турнире UFC - Спорт Mail.ru', '', 1690687258, 'https://news.google.com/atom/articles/CBMiJ2h0dHBzOi8vc3BvcnRtYWlsLnJ1L25ld3MvbW1hLzU3MjE1MDU4L9IBK2h0dHBzOi8vc3BvcnRtYWlsLnJ1L2FtcC9uZXdzL21tYS81NzIxNTA1OC8?oc=5', 1800736088206902245);
INSERT INTO public."NewsRss" VALUES (67316, 'Вы об этом даже не догадывались: витамин D нужен не только для профилактики рахита - Кубанские Новости', '', 1690702269, 'https://news.google.com/atom/articles/CBMifmh0dHBzOi8va3VibmV3cy5ydS9vYnNoY2hlc3R2by8yMDIzLzA3LzMwL3Z5LW9iLWV0b20tZGF6aGUtbmUtZG9nYWR5dmFsaXMtdml0YW1pbi1kLW51emhlbi1uZS10b2xrby1kbHlhLXByb2ZpbGFrdGlraS1yYWtoaXRhL9IBggFodHRwczovL2t1Ym5ld3MucnUvYW1wL29ic2hjaGVzdHZvLzIwMjMvMDcvMzAvdnktb2ItZXRvbS1kYXpoZS1uZS1kb2dhZHl2YWxpcy12aXRhbWluLWQtbnV6aGVuLW5lLXRvbGtvLWRseWEtcHJvZmlsYWt0aWtpLXJha2hpdGEv?oc=5', -9022290848639167799);
INSERT INTO public."NewsRss" VALUES (67317, 'Врач предупредила об опасных последствиях злоупотребления витаминами - Новости Сахалинской области - astv.ru - АСТВ - новости Сахалина и Курил', '', 1690576080, 'https://news.google.com/atom/articles/CBMib2h0dHBzOi8vYXN0di5ydS9uZXdzL3NvY2lldHkvMjAyMy0wNy0yOC12cmFjaC1wcmVkdXByZWRpbGEtb2Itb3Bhc255aC1wb3NsZWRzdHZpeWFoLXpsb3Vwb3RyZWJsZW5peWEtdml0YW1pbmFtadIBAA?oc=5', 5392464331945826164);
INSERT INTO public."NewsRss" VALUES (67318, 'Хватит 1 кусочка: эта чудо-рыба быстро насытит организм белком - суперполезно и недорого - PrimaMedia', '', 1690586100, 'https://news.google.com/atom/articles/CBMiI2h0dHBzOi8vcHJpbWFtZWRpYS5ydS9uZXdzLzE1NTE4NTgv0gEnaHR0cHM6Ly9wcmltYW1lZGlhLnJ1L25ld3MvYW1wLzE1NTE4NTgv?oc=5', 6926533811021022242);
INSERT INTO public."NewsRss" VALUES (67319, 'Психолог предупредила о пугающем тренде в онлайн-знакомствах - Здоровье Mail.ru', '', 1690665795, 'https://news.google.com/atom/articles/CBMiS2h0dHBzOi8vaGVhbHRoLm1haWwucnUvbmV3cy9wc2lob2xvZ19rZXJvbGluX3J1YmVuc3RheW5fZ29zdGxheXRpbmdfbm92YXlhL9IBT2h0dHBzOi8vaGVhbHRoLm1haWwucnUvYW1wL25ld3MvcHNpaG9sb2dfa2Vyb2xpbl9ydWJlbnN0YXluX2dvc3RsYXl0aW5nX25vdmF5YS8?oc=5', -1543081037297303208);
INSERT INTO public."NewsRss" VALUES (67400, 'Полеты в воздушной зоне Москвы и Подмосковья запретили - URA.RU', '', 1690680600, 'https://news.google.com/atom/articles/CBMiIGh0dHBzOi8vdXJhLm5ld3MvbmV3cy8xMDUyNjcxMjYx0gEkaHR0cHM6Ly9hbXAudXJhLm5ld3MvbmV3cy8xMDUyNjcxMjYx?oc=5', 9155780538216373216);
INSERT INTO public."NewsRss" VALUES (67409, 'Беспилотники повредили две башни в Москве Сити - Новые Известия', '', 1690710600, 'https://news.google.com/atom/articles/CBMifWh0dHBzOi8vbmV3aXp2LnJ1L25ld3MvMjAyMy0wNy0zMC9pcS1rdmFydGFsLWktb2tvLWtvbXUtcHJpbmFkbGV6aGF0LWktY2h0by1yYXNwb2xhZ2FldHN5YS12LWF0YWtvdmFubnloLWJhc2hueWFoLXNpdGktNDE0OTEz0gEA?oc=5', 425821023703564305);
INSERT INTO public."NewsRss" VALUES (67511, 'Число погибших из-за урагана в Марий Эл увеличилось до восьми человек - Интерфакс', '', 1690702920, 'https://news.google.com/atom/articles/CBMiJWh0dHBzOi8vd3d3LmludGVyZmF4LnJ1L3J1c3NpYS85MTQwMDnSASJodHRwczovL3d3dy5pbnRlcmZheC5ydS9hbXAvOTE0MDA5?oc=5', 1586310222800700503);
INSERT INTO public."NewsRss" VALUES (67517, 'И тут ее понесло: Захарова попыталась объяснить, зачем Россия напала на Украину (видео) - УНИАН', '', 1690703400, 'https://news.google.com/atom/articles/CBMigQFodHRwczovL3d3dy51bmlhbi5uZXQvcnVzc2lhbndvcmxkL3YtcmYtb3p2dWNoaWxpLXByaWNoaW51LW5hcGFkZW5peWEtbmEtdWtyYWludS10YWtvZ28tYnJlZGEtdnktZXNoY2hlLW5lLXNseXNoYWxpLTEyMzQ1MTIzLmh0bWzSAZQBaHR0cHM6Ly93d3cudW5pYW4ubmV0L3J1c3NpYW53b3JsZC92LXJmLW96dnVjaGlsaS1wcmljaGludS1uYXBhZGVuaXlhLW5hLXVrcmFpbnUtdGFrb2dvLWJyZWRhLXZ5LWVzaGNoZS1uZS1zbHlzaGFsaS1ub3Zvc3RpLXJvc3NpaS1hbXAtMTIzNDUxMjMuaHRtbA?oc=5', -6342121131020871155);
INSERT INTO public."NewsRss" VALUES (67519, 'Путин прибыл на парад ВМФ России. Видео - URA.RU', '', 1690704000, 'https://news.google.com/atom/articles/CBMiIGh0dHBzOi8vdXJhLm5ld3MvbmV3cy8xMDUyNjcxMzAz0gEkaHR0cHM6Ly9hbXAudXJhLm5ld3MvbmV3cy8xMDUyNjcxMzAz?oc=5', -8920511792381796526);
INSERT INTO public."NewsRss" VALUES (67521, 'Число обратившихся в больницу жителей Таганрога после атаки выросло до 22 человек - Интерфакс', '', 1690708260, 'https://news.google.com/atom/articles/CBMiJWh0dHBzOi8vd3d3LmludGVyZmF4LnJ1L3J1c3NpYS85MTQwMTTSASJodHRwczovL3d3dy5pbnRlcmZheC5ydS9hbXAvOTE0MDE0?oc=5', 3893324697137680513);
INSERT INTO public."NewsRss" VALUES (67534, 'Radeon RX 7900 GRE начала появляться в составе готовых игровых ПК в Европе - 3DNews', '', 1690633740, 'https://news.google.com/atom/articles/CBMigQFodHRwczovLzNkbmV3cy5ydS8xMDkwNzYwL3JhZGVvbi1yeC03OTAwLWdyZS1uYWNoYWxhLXBveWF2bHlhdHN5YS12LXNvc3RhdmUtZ290b3ZpaC1pZ3JvdmloLXBrLWV2cm9wZXlza2loLXNpc3RlbW5paC1pbnRlZ3JhdG9yb3bSAYUBaHR0cHM6Ly8zZG5ld3MucnUvMTA5MDc2MC9yYWRlb24tcngtNzkwMC1ncmUtbmFjaGFsYS1wb3lhdmx5YXRzeWEtdi1zb3N0YXZlLWdvdG92aWgtaWdyb3ZpaC1way1ldnJvcGV5c2tpaC1zaXN0ZW1uaWgtaW50ZWdyYXRvcm92L2FtcA?oc=5', -6417846715160300251);
INSERT INTO public."NewsRss" VALUES (67539, 'Овнам — взять кредит, Стрельцам — заплатить налоги: гороскоп на неделю - Блокнот-Волгоград', '', 1690704150, 'https://news.google.com/atom/articles/CBMiXGh0dHBzOi8vYmxva25vdC12b2xnb2dyYWQucnUvbmV3cy9vdm5hbS12enlhdC1rcmVkaXQtc3RyZWx0c2FtLXphcGxhdGl0LW5hbG9naS1nb3Jvcy0xNjMwMzE50gEA?oc=5', -5285438588779942464);
INSERT INTO public."NewsRss" VALUES (67543, 'Абсолютно безотказная: болтливая Винер выдала секрет Кабаевой - Киноафиша.инфо', '', 1690691400, 'https://news.google.com/atom/articles/CBMid2h0dHBzOi8vd3d3Lmtpbm9hZmlzaGEuaW5mby9hcnRpY2xlcy9hYnNvbHl1dG5vLWJlem90a2F6bmF5YS1ib2x0bGl2YXlhLXZpbmVyLXZ5ZGFsYS1zZWtyZXQta2FiYWV2b3lfaWQ1ODEzOV9hMTUyOTMxNTUv0gF7aHR0cHM6Ly93d3cua2lub2FmaXNoYS5pbmZvL2FydGljbGVzL2Fic29seXV0bm8tYmV6b3RrYXpuYXlhLWJvbHRsaXZheWEtdmluZXItdnlkYWxhLXNla3JldC1rYWJhZXZveV9pZDU4MTM5X2ExNTI5MzE1NS9hbXAv?oc=5', 4435510401008444013);
INSERT INTO public."NewsRss" VALUES (67628, 'В Татарстане 24 человека пострадали из-за ветра и ливня — Последние новости Казани и Татарстана - Сетевое издание Inkazan.ru', '', 1690707540, 'https://news.google.com/atom/articles/CBMiZGh0dHBzOi8vaW5rYXphbi5ydS9uZXdzLzIwMjMtMDctMzAvdi10YXRhcnN0YW5lLTI0LWNoZWxvdmVrYS1wb3N0cmFkYWxpLWl6LXphLXZldHJhLWktbGl2bnlhLTI5OTgzNjXSAQA?oc=5', 5896893345294477987);
INSERT INTO public."NewsRss" VALUES (67688, 'Как мы внедряли процесс Performance Overview для грейдинга команды разработки. Часть 1', 'В интернете можно найти много статей о Performance Overview, но я хочу поделиться нашим опытом проведения этого процесса. В цикле из 3 статей, я постараюсь передать вам полную картину – теоретическую часть и практическую часть на основе нашего опыта. При подготовке к проведению, любой сторонний опыт будет полезен.Performance Overview – это ретроспективный процесс, который позволяет оценить сильные и слабые стороны каждого сотрудника и компании в целом. Основная цель – проверить и синхронизировать ожидания работника и организации, а также поощрять сотрудников на основе их общего вклада, а не только экспертизы.Процесс проводится в 5-6 этапов: Читать далее', 1690714806, 'https://habr.com/ru/articles/751320/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751320', -1038273438691131484);
INSERT INTO public."NewsRss" VALUES (67691, '6 механических клавиатур, на которые стоит обратить внимание летом 2023 года', 'О достоинствах и недостатках механических клавиатур на Хабре писали несколько раз. Поэтому снова останавливаться на этом не будем, лучше расскажем об интересных моделях, которые заслуживают нашего с вами внимания. И вот уже для них укажем плюсы и минусы. Ждём вас под катом. Читать далее', 1690714801, 'https://habr.com/ru/companies/ru_mts/articles/751208/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751208', 943513349563318643);
INSERT INTO public."NewsRss" VALUES (67700, 'Расчет численности специалистов поддержки бизнес-приложений', 'Предположим, что вы стали ответственным за направление сопровождения бизнес-приложений (application management service, AMS) и ваш руководитель поставил задачу сформировать стратегию и план действий по организации этой деятельности. Первым делом Вы обратились к популярным фреймворкам, таким как ITIL или COBIT. Однако, не по всем аспектам деятельности удалось найти ценные советы. Поскольку, большинство методик говорят, что сделать, но не описывают как. Мы решили структурировать наш опыт выстраивания процессов и команд поддержки так, чтобы получился понятный и последовательный гайд для руководителя, который сталкивается с задачей выстраивания AMS. Читать далее', 1690718411, 'https://habr.com/ru/articles/751324/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751324', -1039891919807217756);
INSERT INTO public."NewsRss" VALUES (67705, 'Чем отличается реализация non-keyed от keyed в javascript фреймворках?', 'Часто, при разработке сайтов на фреймворках, не придаётся особого внимания деталям, которые в данный фреймворк включены. И это нормально, ведь главная задача фреймворка - чтобы удобно было сайт делать и чтобы он был быстрым и функциональным. Но, эти детали тем и интересны, что узнав некоторые моменты, взгляд на javascript разработку чуть дополняется.  Читать далее', 1690713095, 'https://habr.com/ru/articles/751316/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751316', -1039507846651740252);
INSERT INTO public."NewsRss" VALUES (67735, 'Удар по башне "Москва-Сити": эксперт вскрыл причину бессилия ПВО России - УНИАН', '', 1690714860, 'https://news.google.com/atom/articles/CBMib2h0dHBzOi8vd3d3LnVuaWFuLm5ldC93YXIvdWRhci1wby1iYXNobmUtbW9za3ZhLXNpdGktZWtzcGVydC12c2tyeWwtcHJpY2hpbnUtYmVzc2lsaXlhLXB2by1yb3NzaWktMTIzNDUyODIuaHRtbNIBmQFodHRwczovL3d3dy51bmlhbi5uZXQvd2FyL3VkYXItcG8tYmFzaG5lLW1vc2t2YS1zaXRpLWVrc3BlcnQtdnNrcnlsLXByaWNoaW51LWJlc3NpbGl5YS1wdm8tcm9zc2lpLW5vdm9zdGktdnRvcnpoZW5peWEtcm9zc2lpLW5hLXVrcmFpbnUtYW1wLTEyMzQ1MjgyLmh0bWw?oc=5', -7279185969826273346);
INSERT INTO public."NewsRss" VALUES (67743, 'В Марий-Эл ураган разметал палаточный лагерь, погибли 7 человек (фото) - КЛОПС - главный новостной сайт Калининграда', '', 1690709840, 'https://news.google.com/atom/articles/CBMibWh0dHBzOi8va2xvcHMucnUvb3RoZXIvMjAyMy0wNy0zMC8yNzU5MjUtdi1tYXJpeS1lbC11cmFnYW4tcmF6bWV0YWwtcGFsYXRvY2hueXktbGFnZXItcG9naWJsaS03LWNoZWxvdmVrLWZvdG_SAQA?oc=5', -1813091906890943308);
INSERT INTO public."NewsRss" VALUES (67745, 'Песков: Путину доложили об ударах беспилотников по «Москва-Сити» - URA.RU', '', 1690704300, 'https://news.google.com/atom/articles/CBMiIGh0dHBzOi8vdXJhLm5ld3MvbmV3cy8xMDUyNjcxMzA00gEkaHR0cHM6Ly9hbXAudXJhLm5ld3MvbmV3cy8xMDUyNjcxMzA0?oc=5', -6079008872895120537);
INSERT INTO public."NewsRss" VALUES (67748, 'Александр Ярошук: Судьба большинства калининградцев неразрывно связана с ВМФ России - КЛОПС - главный новостной сайт Калининграда', '', 1690700416, 'https://news.google.com/atom/articles/CBMihAFodHRwczovL2tsb3BzLnJ1L2thbGluaW5ncmFkLzIwMjMtMDctMzAvMjc1OTE4LWFsZWtzYW5kci15YXJvc2h1ay1zdWRiYS1ib2xzaGluc3R2YS1rYWxpbmluZ3JhZHRzZXYtbmVyYXpyeXZuby1zdnlhemFuYS1zLXZtZi1yb3NzaWnSAQA?oc=5', -57585493996243491);
INSERT INTO public."NewsRss" VALUES (67749, 'Парад кораблей, морской бой, дефиле военного оркестра, фейерверк: как в Новороссийске отмечают День ВМФ - Кубанские Новости', '', 1690706901, 'https://news.google.com/atom/articles/CBMijwFodHRwczovL2t1Ym5ld3MucnUvb2JzaGNoZXN0dm8vMjAyMy8wNy8zMC9wYXJhZC1rb3JhYmxleS1tb3Jza295LWJveS1kZWZpbGUtdm9lbm5vZ28tb3JrZXN0cmEtZmV5ZXJ2ZXJrLWthay12LW5vdm9yb3NzaXlza2Utb3RtZWNoYXl1dC1kZW4tdm1mL9IBkwFodHRwczovL2t1Ym5ld3MucnUvYW1wL29ic2hjaGVzdHZvLzIwMjMvMDcvMzAvcGFyYWQta29yYWJsZXktbW9yc2tveS1ib3ktZGVmaWxlLXZvZW5ub2dvLW9ya2VzdHJhLWZleWVydmVyay1rYWstdi1ub3Zvcm9zc2l5c2tlLW90bWVjaGF5dXQtZGVuLXZtZi8?oc=5', -1247582540335950761);
INSERT INTO public."NewsRss" VALUES (67753, 'СМИ: в Великобритании украинский спецназ готовят к захвату Крыма - Ведомости', '', 1690719768, 'https://news.google.com/atom/articles/CBMiR2h0dHBzOi8vd3d3LnZlZG9tb3N0aS5ydS9wb2xpdGljcy9uZXdzLzIwMjMvMDcvMzAvOTg3NjAzLXZlbGlrb2JyaXRhbmlp0gEA?oc=5', -7310151949256514721);
INSERT INTO public."NewsRss" VALUES (67754, 'Тысячи жителей Нигера вышли на протест против Франции - URA.RU', '', 1690718880, 'https://news.google.com/atom/articles/CBMiIGh0dHBzOi8vdXJhLm5ld3MvbmV3cy8xMDUyNjcxMzMy0gEkaHR0cHM6Ly9hbXAudXJhLm5ld3MvbmV3cy8xMDUyNjcxMzMy?oc=5', 6385716803474646389);
INSERT INTO public."NewsRss" VALUES (67759, 'Все просто в бешенстве: Samsung расстроил владельцев Galaxy неожиданным решением - А теперь внимание!', '', 1690713065, 'https://news.google.com/atom/articles/CBMilAFodHRwczovL3ZuaW1hbmllLnByby9zdGlsLXpoaXpuaS9uaWQ2OTE0NV9hdTcxYXVhdWF1X2NyMTIxNzdjcmNyY3JfdnNlLXByb3N0by12LWJlc2hlbnN0dmUtc2Ftc3VuZy1yYXNzdHJvaWwtdmxhZGVsY2V2LWdhbGF4eS1uZW96aGlkYW5ueW0tcmVzaGVuaWVt0gEA?oc=5', 6301955874496264537);
INSERT INTO public."NewsRss" VALUES (67760, 'Сотрудник Larian похвалил Baldurs Gate 3 на Steam Deck и показал два скриншота — Игромания - Игромания', '', 1690716940, 'https://news.google.com/atom/articles/CBMidWh0dHBzOi8vd3d3Lmlncm9tYW5pYS5ydS9uZXdzLzEyOTAwOC9zb3RydWRuaWstbGFyaWFuLXBvaHZhbGlsLWJhbGR1cnMtZ2F0ZS0zLW5hLXN0ZWFtLWRlY2staS1wb2themFsLWR2YS1za3JpbnNob3RhL9IBAA?oc=5', -563521653004196702);
INSERT INTO public."NewsRss" VALUES (67761, 'Продажи Samsung Galaxy Z Flip 5 и Fold 5 в России начались раньше мировых - Канобу', '', 1690711412, 'https://news.google.com/atom/articles/CBMiamh0dHBzOi8va2Fub2J1LnJ1L25ld3MvcHJvZGF6aGktc2Ftc3VuZy1nYWxheHktei1mbGlwLTUtaS1mb2xkLTUtdi1yb3NzaWktbmFjaGFsaXMtcmFuc2hlLW1pcm92eWloLTQ3MjY0NS_SAQA?oc=5', -4253355632060098593);
INSERT INTO public."NewsRss" VALUES (67763, 'Умер муж певицы Натали, музыкальный продюсер Александр Рудин - КЛОПС - главный новостной сайт Калининграда', '', 1690716648, 'https://news.google.com/atom/articles/CBMiZmh0dHBzOi8va2xvcHMucnUvb3RoZXIvMjAyMy0wNy0zMC8yNzU5MjctdW1lci1tdXpoLXBldml0c3ktbmF0YWxpLW11enlrYWxueXktcHJvZHl1c2VyLWFsZWtzYW5kci1ydWRpbtIBAA?oc=5', -3219566671491259774);
INSERT INTO public."NewsRss" VALUES (67766, 'Неестественно высокий лоб, перетянутая кожа: Алла Пугачева вышла в свет с новым лицом - StarHit.ru', '', 1690700400, 'https://news.google.com/atom/articles/CBMifWh0dHBzOi8vd3d3LnN0YXJoaXQucnUvdmlkZW8vbmVlc3Rlc3R2ZW5uby12eXNva2lpLWxvYi1wZXJldHlhbnV0YXlhLWtvemhhLWFsbGEtcHVnYWNoZXZhLXZ5c2hsYS12LXN2ZXQtcy1ub3Z5bS1saWNvbS04OTk5MTgv0gEA?oc=5', -6227998410923971371);
INSERT INTO public."NewsRss" VALUES (67767, 'Гейджи — Порье: видео нокаута в главном бою UFC 291 - Sport24.ru - новости спорта онлайн в России и мире', '', 1690692088, 'https://news.google.com/atom/articles/CBMiVWh0dHBzOi8vc3BvcnQyNC5ydS9tbWEvbmV3cy01NjMyNTAtZ2V5ZHpoaS1wb3J5ZS12aWRlby1ub2thdXRhLXYtZ2xhdm5vbS1ib3l1LXVmYy0yOTHSAVlodHRwczovL2FtcC5zcG9ydDI0LnJ1L21tYS9uZXdzLTU2MzI1MC1nZXlkemhpLXBvcnllLXZpZGVvLW5va2F1dGEtdi1nbGF2bm9tLWJveXUtdWZjLTI5MQ?oc=5', -7017464381231712758);
INSERT INTO public."NewsRss" VALUES (67768, 'Федерация фехтования Украины потребовала лишить Анну Смирнову нейтрального статуса | Новости - ИА Стадион', '', 1690693403, 'https://news.google.com/atom/articles/CBMid2h0dHBzOi8vc3RhZGl1bS5ydS9uZXdzLzMwLTA3LTIwMjMtZmVkZXJhdHNpeWEtZmVodG92YW5peWEtdWtyYWluaS1wb3RyZWJvdmFsYS1saXNoaXQtYW5udS1zbWlybm92dS1uZWl0cmFsbm9nby1zdGF0dXNh0gEA?oc=5', -2425067106692823287);
INSERT INTO public."NewsRss" VALUES (67769, 'Деменко: "Дисквалификация Семака не станет для "Зенита" проблемой в матче против "Динамо" - SPORT.RU', '', 1690706833, 'https://news.google.com/atom/articles/CBMifmh0dHBzOi8vd3d3LnNwb3J0LnJ1L2Zvb3RiYWxsL2RlbWVua28tZGlza3ZhbGlmaWthdHNpeWEtc2VtYWthLW5lLXN0YW5ldC1kbHlhLXplbml0YS1wcm9ibGVtb3ktdi1tYXRjaGUtcHJvdGl2LS9hcnRpY2xlNTU1OTM4L9IBAA?oc=5', 2131974521465700773);
INSERT INTO public."NewsRss" VALUES (67770, 'Как Ирина Винер навсегда изменила художественную гимнастику в России. Она создала империю и правит больше 20 лет - Sport24.ru - новости спорта онлайн в России и мире', '', 1690711500, 'https://news.google.com/atom/articles/CBMigwFodHRwczovL3Nwb3J0MjQucnUvZ3ltbmFzdGljcy9hcnRpY2xlLTU2MzMxMC1naW1uYXN0aWthLWlyaW5hLXZpbmVyLTc1LWxldC1rYWstdmluZXItaXptZW5pbGEta2h1ZG96aGVzdHZlbm51eXUtZ2ltbmFzdGlrdS12LXJvc3NpadIBhwFodHRwczovL2FtcC5zcG9ydDI0LnJ1L2d5bW5hc3RpY3MvYXJ0aWNsZS01NjMzMTAtZ2ltbmFzdGlrYS1pcmluYS12aW5lci03NS1sZXQta2FrLXZpbmVyLWl6bWVuaWxhLWtodWRvemhlc3R2ZW5udXl1LWdpbW5hc3Rpa3Utdi1yb3NzaWk?oc=5', 1085539221954303832);
INSERT INTO public."NewsRss" VALUES (67773, 'Как облегчить физические и психические симптомы климакса: 4 совета врача-гинеколога - Доктор Питер', '', 1690704007, 'https://news.google.com/atom/articles/CBMif2h0dHBzOi8vZG9jdG9ycGl0ZXIucnUvemRvcm92ZS9rYWstb2JsZWdjaGl0LWZpemljaGVza2llLWktcHNpa2hpY2hlc2tpZS1zaW1wdG9teS1rbGltYWtzYS00LXNvdmV0YS12cmFjaGEtZ2luZWtvbG9nYS1pZDg5ODcxNi_SAQA?oc=5', -3635908799145554443);
INSERT INTO public."NewsRss" VALUES (67974, 'Главный военно-морской парад • Президент России - Президент России', '', 1690715025, 'https://news.google.com/atom/articles/CBMiMWh0dHA6Ly93d3cua3JlbWxpbi5ydS9ldmVudHMvcHJlc2lkZW50L25ld3MvNzE4NDjSAQA?oc=5', 1050817528555449984);
INSERT INTO public."NewsRss" VALUES (67980, 'В Нигере проходит многотысячная акция под российским триколором - Фонтанка.Ру', '', 1690718175, 'https://news.google.com/atom/articles/CBMiLGh0dHBzOi8vd3d3LmZvbnRhbmthLnJ1LzIwMjMvMDcvMzAvNzI1NDgzMTIv0gEA?oc=5', 2746476934959193474);
INSERT INTO public."NewsRss" VALUES (67986, 'Atomic Heart подорожала в Турции до 2199 лир — 7500 рублей! - Rozetked', '', 1690713716, 'https://news.google.com/atom/articles/CBMiWGh0dHBzOi8vcm96ZXRrZWQubWUvbmV3cy8yOTg5NS1hdG9taWMtaGVhcnQtcG9kb3JvemhhbGEtdi10dXJjaWktZG8tMjE5OS1saXItNzUwMC1ydWJsZXnSAQA?oc=5', -6186611851118778538);
INSERT INTO public."NewsRss" VALUES (67987, 'Почему Самсунг отказалась от своих процессоров в этом год?... - AndroidInsider.ru', '', 1690718457, 'https://news.google.com/atom/articles/CBMifGh0dHBzOi8vYW5kcm9pZGluc2lkZXIucnUvZXRvLWludGVyZXNuby9wb2NoZW11LXNhbXN1bmctb3RrYXphbGFzLW90LXN2b2loLXByb2N6ZXNzb3Jvdi12LWV0b20tZ29kdS1pLWNodG8tYnVkZXQtZGFsc2hlLmh0bWzSAYABaHR0cHM6Ly9hbmRyb2lkaW5zaWRlci5ydS9ldG8taW50ZXJlc25vL3BvY2hlbXUtc2Ftc3VuZy1vdGthemFsYXMtb3Qtc3ZvaWgtcHJvY3plc3Nvcm92LXYtZXRvbS1nb2R1LWktY2h0by1idWRldC1kYWxzaGUuaHRtbC9hbXA?oc=5', -5776530697233335599);
INSERT INTO public."NewsRss" VALUES (67993, 'Сборная украинских саблисток осталась без наград ЧМ - РБК Спорт', '', 1690723081, 'https://news.google.com/atom/articles/CBMiMWh0dHBzOi8vc3BvcnRyYmMucnUvbmV3cy82NGM2NTY2MzlhNzk0NzM1NmQwNDBhODjSATVodHRwczovL3Nwb3J0cmJjLnJ1L2FtcC9uZXdzLzY0YzY1NjYzOWE3OTQ3MzU2ZDA0MGE4OA?oc=5', 8954672409211578662);
INSERT INTO public."NewsRss" VALUES (68066, 'Путину доложили об атаке беспилотников на Москву - Ведомости', '', 1690705081, 'https://news.google.com/atom/articles/CBMiSWh0dHBzOi8vd3d3LnZlZG9tb3N0aS5ydS9wb2xpdGljcy9uZXdzLzIwMjMvMDcvMzAvOTg3NTg3LXB1dGludS1kb2xvemhpbGnSAQA?oc=5', 5657794402280626622);
INSERT INTO public."NewsRss" VALUES (68070, 'Путин рассказал о мнении Африки о России - 29 июля 2023 - Фонтанка.Ру', '', 1690660398, 'https://news.google.com/atom/articles/CBMiLGh0dHBzOi8vd3d3LmZvbnRhbmthLnJ1LzIwMjMvMDcvMjkvNzI1NDcyNTAv0gEA?oc=5', -8242315681691775956);
INSERT INTO public."NewsRss" VALUES (68079, 'По факту гибели людей на озере Яльчик в Марий Эл возбуждено уголовное дело - Марийская правда - новости Марий Эл и Йошкар-Олы', '', 1690711440, 'https://news.google.com/atom/articles/CBMieWh0dHBzOi8vd3d3Lm1hcnByYXZkYS5ydS9uZXdzL2Fzc29zaWF0aW9ucy9wby1mYWt0dS1naWJlbGktbHl1ZGV5LW5hLW96ZXJlLXlhbGNoaWstdi1tYXJpeS1lbC12b3pidXpoZGVuby11Z29sb3Zub2UtZGVsby_SAQA?oc=5', -4985708051148593001);
INSERT INTO public."NewsRss" VALUES (68176, 'Памяти Кевина Митника — хакера, ломавшего ФБР, АНБ и Кремниевую долину. Часть 1: бурная юность тёмного гения', '
16 июля 2023 года в возрасте 59 лет наш мир покинул Кевин Митник — один из самых знаменитых и архетипичных хакеров в истории. В середине 90-х он считался самым разыскиваемым хакером в мире, и было за что: Митник лихо взламывал сети корпораций и правительства США, обходил большинство систем безопасности, прослушивал агентов ФБР, добывал тонны конфиденциальной информации и данных о банковских картах, включая счета топов Кремниевой долины — вот только денег, как считается, он никогда не воровал. Ну а закрыв проблемы с американским законом — Кевин Митник превратился в одного из лучших специалистов по кибербезопасности. Вспомним о человеке, на основе которого во многом и сформировался классический образ хакера 90-х годов. Читать дальше &rarr;', 1690725602, 'https://habr.com/ru/companies/ruvds/articles/751336/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751336', -675281190317683622);
INSERT INTO public."NewsRss" VALUES (68199, 'По последним данным, при взрыве в Таганроге пострадали 22 человека - Meduza', '', 1690709520, 'https://news.google.com/atom/articles/CBMiZGh0dHBzOi8vbWVkdXphLmlvL25ld3MvMjAyMy8wNy8zMC9wby1wb3NsZWRuaW0tZGFubnltLXByaS12enJ5dmUtdi10YWdhbnJvZ2UtcG9zdHJhZGFsaS0yMi1jaGVsb3Zla2HSAWhodHRwczovL21lZHV6YS5pby9hbXAvbmV3cy8yMDIzLzA3LzMwL3BvLXBvc2xlZG5pbS1kYW5ueW0tcHJpLXZ6cnl2ZS12LXRhZ2Fucm9nZS1wb3N0cmFkYWxpLTIyLWNoZWxvdmVrYQ?oc=5', 6693015062254260840);
INSERT INTO public."NewsRss" VALUES (68203, 'Синоптик рассказал, когда в Подмосковье вернётся хорошая погода - Портал OKA.FM', '', 1690693200, 'https://news.google.com/atom/articles/CBMiXmh0dHBzOi8vd3d3Lm9rYS5mbS9uZXcvcmVhZC9zb2NpYWwvU2lub3B0aWstcmFzc2themFsLWtvZ2RhLXYtUG9kbW9za292ZS12ZXJueW90c3lhLWhvcm9zaGF5YS_SAWJodHRwczovL3d3dy5va2EuZm0vYW1wL25ldy9yZWFkL3NvY2lhbC9TaW5vcHRpay1yYXNza2F6YWwta29nZGEtdi1Qb2Rtb3Nrb3ZlLXZlcm55b3RzeWEtaG9yb3NoYXlhLw?oc=5', -5983786507672920480);
INSERT INTO public."NewsRss" VALUES (68419, 'Нейронные сети, графы и эмерджентность', 'В этой статье я хочу попробовать осветить некоторые интересные, на мой взгляд, области науки, с которыми я сталкивался в контексте работы с нейронными сетями, и найти между ними взаимосвязь. Данная статья не претендует на истину в последней инстанции и является всего лишь попыткой посмотреть на нейронные сети под другим углом. Сразу предупреждаю - я не являюсь каким то глубоким специалистом в этих сферах. Читать далее', 1690727279, 'https://habr.com/ru/articles/751340/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751340', -1038279348566130780);
INSERT INTO public."NewsRss" VALUES (68514, 'Что порой кроется за «успехом»', 'Хочу рассказать вам свой путь в поиске новой работы в 2023 году и поддержать тех, кто сейчас проходит через это. За 6 месяцев я собеседовался в 25 компаний, прошел 54 этапа (а какие-то не прошел), получил 2 оффера и в итоге один из них принял. Если вы сейчас в поиске работы, эта статья будет для вас глотком свежего воздуха. Если же вы матерый специалист, устраивающий процессы онбординга в своей компании, вам это может быть интересно с другой стороны. Читать далее', 1690725056, 'https://habr.com/ru/articles/751284/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751284', -1039907998822596700);
INSERT INTO public."NewsRss" VALUES (68869, 'В Госдуме придумали способ обезопасить россиян от беспилотников', '
    После очередной атаки дронов на Москву, необходимо проработать возможность точечного смс-информирования россиян о движение беспилотников на город. Даванков отметил, что в связи с атаками на Москву необходимо переоборудовать и направить в небо половину дорожных и уличных камер и две трети камер МКАД. 
  ', 1690731604, 'https://lenta.ru/news/2023/07/30/dumabpla/', 1032312419855134676);
INSERT INTO public."NewsRss" VALUES (68873, 'Пассажирка самолета захотела вина, устроила скандал в небе и попала на видео', '
    Пассажирка авиакомпании United Airlines захотела выпить вина и устроила скандал в небе, получив отказ бортпроводника. Уточняется, что рейс следовал из Хьюстона в Лос-Анджелес. Во время полета одна из пассажирок попросила членов экипажа принести ей алкоголь, но получила отказ. Женщина стала спорить с бортпроводниками.
  ', 1690731240, 'https://lenta.ru/news/2023/07/30/vino/', 2037963580740007604);
INSERT INTO public."NewsRss" VALUES (68877, 'ВСУ дважды за день обстреляли автомобильный пункт в Курской области', '
    Вооруженные силы Украины (ВСУ) дважды за 29 июля обстреляли автомобильный пункт «Теткино» в Курской области, сообщает Shot. Первая атака велась в районе четырех часов дня. Под обстрел попал пропускной пункт в Глушковском районе — по нему выпустили 10 артиллерийских снарядов 122 калибра. Спустя час атаки возобновились.
  ', 1690731180, 'https://lenta.ru/news/2023/07/30/tetkino/', 2855403135509790588);
INSERT INTO public."NewsRss" VALUES (68881, 'Парикмахер назвал лучшие прически для маскировки залысин у мужчин', '
    Звездный парикмахер Джей Смолл назвал самые лучшие прически для маскировки залысин у мужчин. Людям, у которых наблюдается значительное выпадение волос на макушке головы, эксперт рекомендует присмотреться к начесам. При этом для поддержания формы данной прически он посоветовал использовать сухой шампунь.
  ', 1690730760, 'https://lenta.ru/news/2023/07/30/manhairs/', -5681588235744289511);
INSERT INTO public."NewsRss" VALUES (68885, 'В России отреагировали на подготовку Великобританией бойцов для захвата Крыма', '
    Подготовка бойцов украинского спецназа Великобританией для захвата Крыма не поможет Киеву вернуть полуостров. Так в беседе с «Лентой.ру» первый заместитель председателя комитета Госдумы по международным делам Алексей Чепа отреагировал на сообщения, что украинские военные обучаются у за границей для этой операции.
  ', 1690730460, 'https://lenta.ru/news/2023/07/30/chepa/', -6649429806283538186);
INSERT INTO public."NewsRss" VALUES (68889, 'Стали известны подробности о состоянии актера Ивана Краско', '
    Состояние здоровья народного артиста России Ивана Краско постепенно улучшается. У 92-летнего актера диагностировали неблагоприятные последствия инсульта, в том числе галлюцинации. В воскресенье, 30 июля, как сообщает издание, Краско перевели в реабилитационный корпус больницы. 
  ', 1690730400, 'https://lenta.ru/news/2023/07/30/mash_krasko/', 3971036041410877789);
INSERT INTO public."NewsRss" VALUES (68891, 'В Брянской области сбили дрон-камикадзе ВСУ', '
    В Брянской области ликвидировали дрон-камикадзе вооруженных сил Украины (ВСУ). Беспилотный летательный аппарат со взрывчаткой был уничтожен в районе деревни Грудская при помощи антидронового ружья. Сбитый беспилотник после падения на землю взорвался. Никто не пострадал. 
  ', 1690730340, 'https://lenta.ru/news/2023/07/30/dron/', 2038438141208098484);
INSERT INTO public."NewsRss" VALUES (68897, 'Россияне раскрыли свое отношение к служебным романам', '
    Больше трети россиян считают служебные романы недопустимыми, а семь процентов просят начальство вмешаться в ситуацию в подобном случае. При этом 50 процентов респондентов ответили, что служебные романы допустимы. Однако 24 процента из них отметили, что они возможны в том случае, если партнеры скрывают это от коллег.
  ', 1690730160, 'https://lenta.ru/news/2023/07/30/opros/', -6656311052602965770);
INSERT INTO public."NewsRss" VALUES (68901, 'Макрон пообещал защитить французов в Нигере', '
    Президент Франции Эммануэль Макрон настроен защитить своих сограждан в Нигере в случае атак на них. «Кто бы ни совершал нападения на граждан, армию, дипломатов и интересы страны, получит от Франции ответ в немедленной и непреклонной манере», — подчеркивается в заявлении. 
  ', 1690729800, 'https://lenta.ru/news/2023/07/30/francuzish/', -3514079208176723191);
INSERT INTO public."NewsRss" VALUES (68906, 'Экипажу остановившего атаку колонны ВСУ российского танка пообещали награду', '
    Временно исполняющий обязанности (врио) главы Донецкой народной республики (ДНР) Денис Пушилин пообещал наградить экипаж танка, в одиночку остановившего атаку колонны Вооруженных сил Украины (ВСУ). Он отметил, что командир отличившейся дивизии имеет прямое отношение к освобождению населенных пунктов на севере ДНР.
  ', 1690729080, 'https://lenta.ru/news/2023/07/30/tank_award/', -9019386294926066354);
INSERT INTO public."NewsRss" VALUES (68911, 'Стало известно о проблемах ВСУ при использовании дронов', '
    Вооруженные силы Украины (ВСУ) отказываются использовать дроны на фронте из-за бюрократии. «Если беспилотник потерян, то для его списания требуется много документов и целое расследование», — заявил бизнесмен Игорь Криничко, отметив, что из-за этого военные зачастую не ставят дроны на баланс.
  ', 1690728720, 'https://lenta.ru/news/2023/07/30/burokratiya/', -8806340468666769850);
INSERT INTO public."NewsRss" VALUES (68915, 'Заключенный сбежал из СИЗО благодаря уборке и попал на видео', '
    В СИЗО-1 Амурской области заключенного отправили убираться в комнате для свиданий, а он воспользовался случаем и сбежал через окно для приема передач. В региональном управлении ФСИН заявили, что побег совершил 22-летний мужчина по имени Роман Зырянов. Он был осужден за кражу и должен был выйти на свободу в 2025-м.
  ', 1690728000, 'https://lenta.ru/news/2023/07/30/uborka/', -3717837380331541024);
INSERT INTO public."NewsRss" VALUES (68920, 'Жители Земли увидят в августе два суперлуния', '
    Жители Земли смогут увидеть в августе два суперлуния — феномен, при котором луна приближается к нашей планете на минимальное расстояние. Первое суперлуние произойдет 1 августа, а второе — 30 августа. Как отмечают астрономы, в течение одного месяца редко можно увидеть сразу два таких феномена. 
  ', 1690727880, 'https://lenta.ru/news/2023/07/30/moon_earth/', -4424963142681789111);
INSERT INTO public."NewsRss" VALUES (68923, 'Стали известны обстоятельства кончины мужа певицы Натали', '
    Тело мужа певицы Натали продюсера Александра Рудина обнаружили на козырьке подъезда многоквартирного дома в Москве, об этом стало известно 30 июля. Утверждается, что Рудина не стало еще в четверг, спустя две недели после ухода отца, из-за чего он тяжело переживал. 
  ', 1690727640, 'https://lenta.ru/news/2023/07/30/rudinn/', -3716030452572325392);
INSERT INTO public."NewsRss" VALUES (68926, '«Рубин» вновь упустил победу в матче РПЛ', '
    Казанский «Рубин» сыграл вничью с «Оренбургом» в матче второго тура Российской премьер-лиги (РПЛ). Встреча прошла в Казани на стадионе «Ак Барс Арена» и завершилась со счетом 1:1. На 35-й минуте счет открыл полузащитник казанцев Александр Зотов. На 81-й минуте защитник Матиас Перес сравнял счет. 
  ', 1690727460, 'https://lenta.ru/news/2023/07/30/rub_oren/', 2131362188687132228);
INSERT INTO public."NewsRss" VALUES (68928, 'В одном из старейших сел Башкирии появится этнопарк русской культуры', '
    В селе Красный Яр, которое считается одним из старейших в Башкирии, появится этнопарк русской культуры. Об этом сообщает «МК» со ссылкой на заместителя министра ЖКХ республики Вилория Угарова. Он добавил, что всего на развитие общественной территории в селе будет направлено 2,7 миллиона рублей.
  ', 1690726853, 'https://lenta.ru/news/2023/07/30/etnopark/', -425465269237297915);
INSERT INTO public."NewsRss" VALUES (68930, 'Минобороны показало видео работы «Аллигатора» в зоне СВО', '
    Минобороны показало видео работы российского разведывательно-ударного вертолета Ка-52 «Аллигатор» в зоне специальной военной операции. Экипаж вертолета выявил боевую машину пехоты (БМП) противника и нанес удар направляемой ракетой. Цель была уничтожена прямым попаданием. 
  ', 1690726740, 'https://lenta.ru/news/2023/07/30/allig/', -6647931050908442378);
INSERT INTO public."NewsRss" VALUES (68932, 'Песков отказался раскрывать подробности послания Путина Ким Чен Ыну', '
    Пресс-секретарь президента России Дмитрий Песков отказался раскрывать подробности послания российского лидера Владимира Путина главе Корейской Народной Демократической Республики (КНДР) Ким Чен Ыну. «Это было личное послание», — заявил представитель Кремля на вопрос о содержании послания.
  ', 1690726200, 'https://lenta.ru/news/2023/07/30/peskov_kim/', -7425161755200290738);
INSERT INTO public."NewsRss" VALUES (68934, 'В Индии сообщили о резкой вспышке лихорадки денге', '
    В Нью-Дели резко растет число случаев лихорадки денге, вирусного заболевания, вызывающего в тяжелых случаях геморрагический шок. Об этом сообщил министра здравоохранения города Саурабха Бхардваджа. Более 40 человек заразились в июне, большинство из них стали переносчиками второго серотипа вируса, DENV-2.
  ', 1690725420, 'https://lenta.ru/news/2023/07/30/india_denge/', 18745138277716664);
INSERT INTO public."NewsRss" VALUES (68936, 'Экс-разведчик США назвал танки Leopard ловушкой для ВСУ', '
    Экс-разведчик Вооруженных сил США Скотт Риттер назвал танки Leopard бесполезными и непрактичными для Вооруженных сил Украины (ВСУ). Из-за того, что украинские военные видели в немецких танках некое «чудо-оружие», они стали для них ловушкой, поскольку ВСУ не умеют ими пользоваться и нормально их ремонтировать.
  ', 1690725360, 'https://lenta.ru/news/2023/07/30/usaritter/', -7910378869916042828);
INSERT INTO public."NewsRss" VALUES (68938, 'Военным Нигера пригрозили силой в случае отказа вернуть президента', '
    Сообщество стран Западной Африки заявило, что дает военным Нигера неделю на возвращение президента страны Мохамеда Базума к власти и на сдачу властных полномочий. Глава комиссии сообщества Омар Алье Туре подчеркнул, что меры могут включать «применение силы», но не уточнил, насколько именно жесткое. 
  ', 1690724940, 'https://lenta.ru/news/2023/07/30/nigerianpresident/', 3956687237282319421);
INSERT INTO public."NewsRss" VALUES (68940, 'Работу лагеря на Алтае приостановили после массового отравления детей', '
    Роспотребнадзор приостановил работу детского оздоровительного лагеря «Горный орленок» на Алтае после массового отравления детей. С 26 по 29 июля в лагере зафиксировано 69 случаев заражения с обнаружением инфекции, в том числе у детей в возрасте от 7 до 17 лет. Глава СКР Бастрыкин взял расследование дела на контроль. 
  ', 1690724834, 'https://lenta.ru/news/2023/07/30/massovoe/', -5676716444006998807);
INSERT INTO public."NewsRss" VALUES (68942, 'Зеленского предупредили о социальном взрыве на Украине', '
    Продолжение мобилизации приведет к социальному взрыву на Украине. С таким предупреждением выступил Олег Соскин, экс-советник бывшего президента республики Леонида Кучмы. Бывший советник обратил внимание на сопротивление, которое оказывают люди при задержании для мобилизации на фронт.
  ', 1690724700, 'https://lenta.ru/news/2023/07/30/soskin/', -3716026120141694912);
INSERT INTO public."NewsRss" VALUES (68944, 'Нигеру дали неделю на возвращение президента к власти', '
    Экономическое сообществе стран Западной Африки дало военным в Нигере неделю на возвращение к власти президента Мохамеда Базума. Как пояснили представители сообщества, после этого входящие в него страны могут применить против пришедших к власти в Нигере в результате государственного переворота любые меры.
  ', 1690724640, 'https://lenta.ru/news/2023/07/30/nedelya/', -6509864121085460631);
INSERT INTO public."NewsRss" VALUES (68945, 'Экономическое сообщество стран Западной Африки закроет границы с Нигером', '
    Экономическое сообщество стран Западной Африки приняло решение закрыть границы между входящими в него государствами и Нигером. Активы страны в ЦБ ЭКОВАКС и коммерческих банках будут заморожены. Коммерческие и финансовые транзакции с государством также приостанавливаются.
  ', 1690724520, 'https://lenta.ru/news/2023/07/30/niger_close/', -6882260512923778399);
INSERT INTO public."NewsRss" VALUES (68946, 'Глава ОКР оценил призывы депутатов к выходу из олимпийского движения', '
    Президент Олимпийского комитета России (ОКР) Станислав Поздняков оценил высказывания депутата Госдумы Сергея Миронова об олимпийском движении. «Призыв выйти из олимпийского движения — это игра на руку тем, кто добивается изоляции нашей страны», — раскритиковал политика он.
  ', 1690724100, 'https://lenta.ru/news/2023/07/30/pozdnyakov/', 5802168048875016695);
INSERT INTO public."NewsRss" VALUES (68947, 'Гарик Сукачев впервые вышел на связь после новостей о госпитализации', '
    Рок-музыкант Гарик Сукачев впервые вышел на связь после новостей о госпитализации. «Я загремел в больницу. <...> Прошу у всех у вас, конечно же, прощения. Но все мы живые люди, все мы болеем», — сказал он, обращаясь к фанатам, которые планировали увидеть его на концерте в Карелии.
  ', 1690724040, 'https://lenta.ru/news/2023/07/30/sukachev_gospital/', -7597672817550693336);
INSERT INTO public."NewsRss" VALUES (68948, 'В Киеве начали демонтаж герба СССР с монумента «Родина-мать»', '
    В Киеве начались работы по демонтажу герба СССР с монумента «Родина-мать». Демонтаж приурочен к празднованию Дня независимости Украины, который будет отмечаться 24 августа. Взамен советского герба на щит скульптуры планируют нанести украинский трезубец. Статую планируют переименовать в «Украину-мать».
  ', 1690723680, 'https://lenta.ru/news/2023/07/30/gerb/', 2036380606761334452);
INSERT INTO public."NewsRss" VALUES (68949, 'Раскрыта стоимость закрытого концерта Орбакайте в России', '
    Закрытый концерт певицы Кристины Орбакайте в России обходится в 50 тысяч евро или примерно в 5 миллионов рублей. По данным Mash, певица, долгое время живущая в США, готова приезжать в страну на корпоративы. Если организаторы не предлагают площадку для выступлений, ее представители настаивают на проведении в Турции.
  ', 1690723080, 'https://lenta.ru/news/2023/07/30/orbak_price/', -8616200597420191050);
INSERT INTO public."NewsRss" VALUES (68950, 'Названы возможные признаки подготовки Китая к войне', '
    Закупки сырья и еды могут быть признаками подготовки КНР к войне. Китай потратил десятилетия на укрепление экономики от санкций, модернизацию вооруженных сил и позаботился о продовольственной безопасности на фоне намерения Пекина любыми средствами вернуть под свой контроль Тайвань, пишет The Economist.
  ', 1690722960, 'https://lenta.ru/news/2023/07/30/china_war/', 6313053366573885945);
INSERT INTO public."NewsRss" VALUES (68951, 'Шансы завершить украинский кризис не на поле боя оценили', '
    Большинство конфликтов в истории заканчивались не на поле боя, а за столом переговоров, утверждает политолог, кандидат политических наук Станислав Бышок. В разговоре с «Лентой.ру» он оценил шансы завершить украинский кризис политическими методами и объяснил, от чего зависит начало диалога между сторонами.
  ', 1690722610, 'https://lenta.ru/news/2023/07/30/politika/', -7127079820518887823);
INSERT INTO public."NewsRss" VALUES (68952, 'Украинский офицер рассказал о планах России полностью заглушить Starlink', '
    Россия получила технологию, позволяющую глушить систему спутниковой связи Starlink, и готовится к ее внедрению в войска. Об этом рассказал командир роты ударных БПЛА Вооруженных сил Украины с позывным Мадьяр. Устройства связи Starlink были переданы украинской армии американским миллиардером и изобретателем Маском.
  ', 1690722540, 'https://lenta.ru/news/2023/07/30/starlink_ua/', -8865602803689465326);
INSERT INTO public."NewsRss" VALUES (68953, 'Зеленский посетил украинских военных в Ивано-Франковске', '
    Глава Украины Владимир Зеленский посетил реабилитационный центр для раненных украинских военных. Он навестил раненных в центре, расположенном в городе Ивано-Франковск, где проходят лечение получившие ранения военнослужащие. Зеленский сфотографировался с раненным и поблагодарил их за службу
  ', 1690722120, 'https://lenta.ru/news/2023/07/30/zilensk/', 1271914990725395508);
INSERT INTO public."NewsRss" VALUES (68954, 'Почти половину бюджета Украины составила западная помощь', '
    Почти половина всех средств, поступивших на финансирования бюджета Украины в 2023 году, были получены из-за рубежа. Как утверждает председатель парламентского комитета по вопросам бюджета Роксолана Пидласа, западная бюджетная помощь для республики с начала 2023 года составила 25,3 миллиарда долларов.
  ', 1690721021, 'https://lenta.ru/news/2023/07/30/polovina/', -7127085111862342031);
INSERT INTO public."NewsRss" VALUES (68955, 'Стрелявшего по прохожим в Таганроге задержали', '
    Росгвардия задержала пьяного мужчину, который заперся в пивной в Таганроге и начал стрелять по прохожим. Shot утверждает, что задержанный сейчас находится в отделении полиции. Мужчина забежал в магазин разливного пива на Александровской улице и начал стрелять из окна заведения из травматического оружия. 
  ', 1690720920, 'https://lenta.ru/news/2023/07/30/strel/', -6651087960009064202);
INSERT INTO public."NewsRss" VALUES (68956, 'Стало известно о передаче генералами ВСУ информации о коррупции Зеленского', '
    Генералы ВСУ могли передать ЦРУ США информацию о краже президентом страны Владимиром Зеленским финансовой помощи. Об этом пишет портал Al Mayadeen со ссылкой на статью журналиста Сеймура Херша, сообщившего, что украинского лидера обвиняют в незаконном присвоении 400 миллионов долларов западных фондов помощи.
  ', 1690720320, 'https://lenta.ru/news/2023/07/30/400/', -6615137627560037256);
INSERT INTO public."NewsRss" VALUES (68957, 'В Нижегородской области появился музей русского патриаршества', '
    В Воскресенском кафедральном соборе Арзамаса Нижегородской области, который открылся после масштабных реставрационных работ, появился Музей патриаршества. Об этом сообщает «Российская газета». Новая экспозиция расположилась в подклети — ранее это пространство цокольного этажа собора было недоступно для посетителей.
  ', 1690720196, 'https://lenta.ru/news/2023/07/27/patriarshestvo/', -3653979995775757537);
INSERT INTO public."NewsRss" VALUES (68958, 'Протестующие подожгли посольство Франции в Нигере', '
    Протестующие в Нигере устроили поджог здания посольства Франции. Дверь посольства охвачена огнем, силы полиции сдерживают толпу, не давая ворваться внутрь. В акции протеста участвуют тысячи местных жителей, требующих закрытия иностранных военных баз на территории страны.
  ', 1690719840, 'https://lenta.ru/news/2023/07/30/podojgl/', -7808482853670096486);
INSERT INTO public."NewsRss" VALUES (68959, 'В Армении арестовали экс-посла страны в России и его сына', '
    Суд в Ереване арестовал на два месяца бывшего посла Армении в России, экс-директора Межгосударственного фонда гуманитарного сотрудничества СНГ Армена Смбатяна и его сына по обвинению в мошенничестве. Как писала Генпрокуратура, уголовное преследование Смбатяна и его сына Сергея было инициировано 27 июля. 
  ', 1690719240, 'https://lenta.ru/news/2023/07/30/armenia/', 7397243828969656432);
INSERT INTO public."NewsRss" VALUES (68960, 'На митинге в Нигере заметили российские флаги', '
    Сторонники военных, захватившие власть в результате переворота в Нигере, вышли на митинг с российскими флагами, сообщает Le Monde. Протестующие прошли маршем по улицам столицы Ниамей. Они выкрикивали имя российского президента Владимира Путина и антифранцузские лозунги.
  ', 1690719180, 'https://lenta.ru/news/2023/07/30/flags/', -6656313907678531338);
INSERT INTO public."NewsRss" VALUES (68961, 'США открыли охоту на способный нарушить ход военных операций код КНР', '
    По словам представителей американских военных, администрация президента страны Джо Байдена открыла охоту на вредоносный компьютерный код, который, по их мнению, Китай «спрятал» глубоко в сетях, управляющих электросетями, системами связи и водоснабжения. Благодаря им функционируют базы военных США.
  ', 1690718880, 'https://lenta.ru/news/2023/07/30/razvedka/', -6224671084197748519);
INSERT INTO public."NewsRss" VALUES (68962, 'Балицкий сообщил об ударе по районам сосредоточения ВСУ в Запорожье', '
    Российские войска нанесли удар по районам сосредоточения Вооруженных сил Украины (ВСУ) в Запорожской области. Об этом сообщил врио главы региона Евгений Балицкий. По его словам, российская разведка вскрыла три района сосредоточения противника. Войска нанесли по ним огневой удар.
  ', 1690718820, 'https://lenta.ru/news/2023/07/30/udar_zaporozh/', 2693358801051081784);
INSERT INTO public."NewsRss" VALUES (68963, 'Инструктор по йоге назвал позы для облегчения боли в спине', '
    Инструктор по йоге Пурави Джош назвал позы для облегчения боли в спине. Он рекомендовал делать позу ребенка, кошки, собаки мордой вниз, а также сфинкса. «Правильные упражнения и позы йоги действительно могут помочь вам почувствовать себя лучше», — объяснил специалист. 
  ', 1690718760, 'https://lenta.ru/news/2023/07/30/yoga/', 2035733828460410548);
INSERT INTO public."NewsRss" VALUES (68964, 'В Нальчике появится Сиреневый бульвар', '
    Сиреневый бульвар появится в столице Кабардино-Балкарии Нальчике. Об этом сообщает портал «Это Кавказ» со ссылкой на официальный портал органов власти республики. Как отмечается, он станет частью нового сквера, который планируется разбить в пятом микрорайоне по улице Тарчокова.
  ', 1690718283, 'https://lenta.ru/news/2023/07/27/bulvar/', -3844933340635045136);
INSERT INTO public."NewsRss" VALUES (68965, 'В Африке призвали отказаться от использования iPhone', '
    Советник президента ЮАР по кибербезопасности Джозеф Пу призвал представителей правительств отказаться от устройств Apple. Свое заявление Джозеф Пу сделал на полях саммита «Россия — Африка». Советник полагает, что главы государств, находящиеся рядом с несколькими айфонами не могут считать себя в безопасности. 
  ', 1690717833, 'https://lenta.ru/news/2023/07/30/noifone/', -6508108279703862903);
INSERT INTO public."NewsRss" VALUES (68966, 'Зеленского заподозрили в рассекречивании пункта управления ВСУ', '
    Визит президента Украины Владимира Зеленского в Днепропетровск мог раскрыть России местонахождение пункта управления Вооруженных сил Украины (ВСУ). Об этом рассказал американский эксперт, старший научный сотрудник Центра политики безопасности и Йорктаунского института Стивен Брайен.
  ', 1690717620, 'https://lenta.ru/news/2023/07/30/zel_dnepr/', 1799855723363906894);
INSERT INTO public."NewsRss" VALUES (68967, 'В Госдуме раскритиковали запрещающих все подряд депутатов', '
    Депутат Госдумы и телеведущий Евгений Попов прокомментировал инициативы своих коллег, которые предлагают запретительные меры для решения тех или иных проблем. «Некоторые политики уверены, что запреты — их основная функция. Возможно, больше они ничего не умеют», — заявил Попов. 
  ', 1690717500, 'https://lenta.ru/news/2023/07/30/zapret/', -3712110986577464208);
INSERT INTO public."NewsRss" VALUES (68968, 'Россия и ЮАР поработают над системой безопасных выборов', '
    Главы спецслужб ЮАР посетят Россию для работы над системой безопасных выборов 2024 года в обеих странах. Такое решение в ЮАР объяснили желанием «многих людей» попытаться нарушить работу избирательных систем. «Мы можем начать эту работу сразу после этого саммита "Россия — Африка"», — считает советник президента ЮАР.
  ', 1690716540, 'https://lenta.ru/news/2023/07/30/yuarr/', -6655852181226872586);
INSERT INTO public."NewsRss" VALUES (68969, 'Депутат Госдумы пригрозил Киеву после атаки на Москву', '
    Депутат Госдумы от крымского региона Михаил Шеремет пригрозил украинским властям ответом после атаки беспилотников на Москву, произошедшей 30 июля. «Зеленский заигрался в роль мальчиша-плохиша», — добавил депутат. Ранним утром 30 июля в башню «Москвы-Сити» попал украинский беспилотник.
  ', 1690716000, 'https://lenta.ru/news/2023/07/30/1123/', 2032373777842632372);
INSERT INTO public."NewsRss" VALUES (68970, 'Неизвестный заперся в таганрогской пивной и стрелял по прохожим', '
    Неизвестный житель Таганрога забежал в местную пивную, заперся там и открыл огонь по прохожим из окон. Инцидент произошел на улице Александровской в воскресенье, 30 июля. На место оперативно прибыла Росгвардия и задержала стрелка. Из какого оружия мужчина стрелял по прохожим, не уточняется.
  ', 1690715760, 'https://lenta.ru/news/2023/07/30/mash_taganrog/', 2945120003329170216);
INSERT INTO public."NewsRss" VALUES (68971, 'Оппозиция Нигера поддержала мятежников', '
    Ведущая оппозиционная партия Нигера «МОДЕН/ФА-Лумана» (Нигерийское демократическое движение за Африканскую федерацию) объявила, что поддерживает военных, захвативших власть в стране в результате государственного переворота. Об этом пишет ТАСС. В оппозиции уверены, что госпереворот откроет «новые страницы надежд». 
  ', 1690715580, 'https://lenta.ru/news/2023/07/30/87474/', -6644952722611433226);
INSERT INTO public."NewsRss" VALUES (68972, 'Пассажир нашел опасный способ не платить за багаж в полете и вызвал споры в сети', '
    Пассажир самолета обманул авиакомпанию, чтобы не платить за перевес багажа, и вызвал споры в сети. Свой опасный способ избежать доплаты он показал в TikTok. Несмотря на радость автора видео, не все его подписчики посчитали лайфхак удачным. Пользователи заметили, что пассажир подвергает опасности попутчиков.
  ', 1690715100, 'https://lenta.ru/news/2023/07/30/bag/', -6610956998199036808);
INSERT INTO public."NewsRss" VALUES (68973, 'Футболистка в хиджабе впервые в истории сыграла на чемпионате мира', '
    Футболистка женской сборной Марокко Нухайла Бензина стала первой женщиной, сыгравшей на чемпионате мира в хиджабе. Защитница вышла на поле в матче против сборной Южной Кореи. Марокко одержало победу со счетом 1:0. Ранее ФИФА не разрешала игрокам носить на матчах головные уборы в религиозных целях.
  ', 1690715040, 'https://lenta.ru/news/2023/07/30/football/', -8155048367338283871);
INSERT INTO public."NewsRss" VALUES (68974, 'Неизвестный поджег релейный шкаф и задержал российский поезд', '
    В Калужской области сотрудники правоохранительных органов начали розыск неизвестного диверсанта, устроившего поджог на железной дороге. ЧП произошло около двух ночи. Злоумышленник отогнул дверцу релейного шкафа, облил находившееся внутри оборудование горючей жидкостью и поджег. 
  ', 1690715040, 'https://lenta.ru/news/2023/07/30/reley/', -6652125962442247946);
INSERT INTO public."NewsRss" VALUES (68975, 'Папа Римский призвал Россию возобновить зерновую сделку', '
    Папа Римский Франциск после традиционной воскресной проповеди призвал Россию возобновить зерновую сделку. «Призываю своих братьев и власти России вернуться к черноморской инициативе, чтобы зерно могло перевозиться в безопасности», — высказался он. Действие сделки было прекращено 17 июля.
  ', 1690714800, 'https://lenta.ru/news/2023/07/30/pope_asks/', 8958039472054552254);
INSERT INTO public."NewsRss" VALUES (68976, 'Российские военные рассказали о бегстве украинских солдат под Марьинкой', '
    Экипажи российской БМП и двух танков сумели обратить в бегство подразделение Вооруженных сил Украины (ВСУ), удерживающее один из опорных пунктов под Марьинкой. Об этом бойцы рассказали в интервью газете «Известия». Машины сумели подойти к «опорнику» почти вплотную, на расстояние 10 метров.
  ', 1690714440, 'https://lenta.ru/news/2023/07/30/marinka_rus/', -4373028099312825999);
INSERT INTO public."NewsRss" VALUES (68977, 'Уничтожение украинской САУ «Гвоздика» показали на видео', '
    Кадры уничтожения украинской самоходной артиллерийской установки (САУ) «Гвоздика» в Херсонской области в районе населенного пункта Антоновка показали на видео. На кадрах видно, как прямое попадание боеприпаса разрывает на части находящуюся возле грунтовой дороге самоходку ВСУ.
  ', 1690714414, 'https://lenta.ru/news/2023/07/30/exp/', -6602788778124331912);
INSERT INTO public."NewsRss" VALUES (68978, 'Народная артистка России Мирошниченко попала в реанимацию', '
    Народная артистка РСФСР Ирина Мирошниченко попала в больницу из-за недомогания. По данным канала «112», 81-летняя актриса находится в реанимации. Мирошниченко стало плохо утром, из-за ухудшения здоровья она была госпитализирована — у нее диагностировали тяжелую форму гриппа. 
  ', 1690714080, 'https://lenta.ru/news/2023/07/30/mirosh/', -3716683517492188320);
INSERT INTO public."NewsRss" VALUES (68979, 'Появилась информация о проблемах в переговорах «Динамо» и «Лацио» по Захаряну', '
    Стало известно о проблемах в переговорах московского «Динамо» и римского «Лацио» по российскому полузащитнику Арсену Захаряну. По данным источника, переговоры сторон оказались близки к тупику. Портал Transfermarkt оценивает стоимость 20-летнего россиянина в 15 миллионов евро.
  ', 1690713944, 'https://lenta.ru/news/2023/07/30/zakharyan/', 503846388204334170);
INSERT INTO public."NewsRss" VALUES (68980, 'Замглавы Архангельска арестовали по делу о получении крупной взятки', '
    Заместителя главы Архангельска Владислава Шевцова арестовали по подозрению в получении крупной взятки. По делу проходит еще один фигурант — Олег Пугин из ООО «Спецавтохозяйство по уборке города». Ему суд избрал меру пресечения в виде домашнего ареста. Всего фигуранты получили более 3,5 миллиона рублей взятками. 
  ', 1690713720, 'https://lenta.ru/news/2023/07/30/aressst/', 7400592727198552176);
INSERT INTO public."NewsRss" VALUES (68981, 'ВС России ударили по прибывшим на поле боя военным ВСУ и попали на видео', '
    Telegram-канал «Военный осведомитель» опубликовал кадры, на которых можно увидеть удары ВС России по позициям Вооруженных сил Украины на поле боя. На видео попал эпизод высадки бойцов ВСУ из боевой машины пехоты M2 «Брэдли». Сразу после этого ВС России открыли по ним огонь. 
  ', 1690713660, 'https://lenta.ru/news/2023/07/30/4566788/', 2869651521011181584);
INSERT INTO public."NewsRss" VALUES (68982, 'Путин пожал руку многодетному отцу из Магадана после парада ВМФ', '
    Президент России Владимир Путин встретился в Санкт-Петербурге с многодетной семьей из Магадана, которой помогли приехать на парад Военно-морского флота (ВМФ), и пожал руку главе семейства Вадиму Горелову. Ранее семья приехала в Москву. После встречи с президентом им помогли приехать на парад ВМФ в Петербург.
  ', 1690713120, 'https://lenta.ru/news/2023/07/30/putin_pozhal/', -6620995016205552942);
INSERT INTO public."NewsRss" VALUES (68983, 'Певица Натали назвала причину смерти мужа', '
    Музыкальный продюсер Александр Рудин, муж российской певицы Натали умер от последствий коронавируса. Причину смерти супруга в беседе с ТАСС назвала сама артистка. По словам певицы, у ее мужа наблюдались определенные осложнения после перенесенного заболевания. «Два года боролись мы, но не сумели», — сказала она.
  ', 1690712880, 'https://lenta.ru/news/2023/07/30/nazvala/', -6509868150155060823);
INSERT INTO public."NewsRss" VALUES (68984, 'Военный аналитик предсказал провокацию ВСУ в Черном море', '
    Вооруженные силы Украины (ВСУ) могут готовить провокацию в Черном море, чтобы обвинить Россию в атаке на гражданские суда. Об этом заявил военный аналитик Борис Джерелиевский. По его словам, Киев решил закупить у Лондона суда, который, согласно легенде, попытаются прорваться в порт Одессы.
  ', 1690712700, 'https://lenta.ru/news/2023/07/30/analitik/', 9010688949591118976);
INSERT INTO public."NewsRss" VALUES (68985, 'Раскрыто дешевое средство для сохранения полотенец чистыми надолго', '
    Генеральный директор прачечной Laundryheap Деян Димитров раскрыл дешевое средство для сохранения полотенец чистыми надолго. Эксперт посоветовал в стирке использовать пищевую соду. По его словам, данный продукт хорошо справляется с загрязнениями и нейтрализует неприятные запахи.
  ', 1690712640, 'https://lenta.ru/news/2023/07/30/stirkasoda/', -6262015035612621159);
INSERT INTO public."NewsRss" VALUES (68986, 'Прогуливавшийся в Москве лось попал на видео', '
    Лось прогуливавшийся недалеко от центра Москвы попал на видео. На кадрах видно, как животное стоит возле Варшавского шоссе неподалеку от станции метро Нагатинская. Не смотря на множество машин на шоссе и проезжающий по мосту электропоезд, лось сохранял спокойствие. После он ушел дворами в область. 
  ', 1690712520, 'https://lenta.ru/news/2023/07/30/video/', -6651738979634827018);
INSERT INTO public."NewsRss" VALUES (68987, 'Соседей Нигера заподозрили в подготовке интервенции', '
    Военные, находящиеся у власти в Нигере после государственного переворота, предупредили соседние страны о недопустимости вооруженной агрессии. Как заявил официальный представитель Национального совета спасения родины полковник Амаду Абдраман, некоторые соседи страны могут планировать интервенцию. 
  ', 1690712520, 'https://lenta.ru/news/2023/07/30/458585/', -3740763812089294768);
INSERT INTO public."NewsRss" VALUES (68988, 'На Московском урбанфоруме пройдут «Спортивные выходные»', '
    На площадке Московского урбанистического форума в Гостином Дворе пройдут тренировки проекта «Спортивные выходные». После занятий гости смогут увидеть достижения города в социальной сфере и интерактивную выставку. Кроме того, в честь трехлетия проекта 5 и 6 августа на площадке в «Лужниках» пройдет фестиваль.
  ', 1690712100, 'https://lenta.ru/news/2023/07/30/sport/', -6655183643284586250);
INSERT INTO public."NewsRss" VALUES (68989, 'Число жертв непогоды в Приволжье выросло до десяти человек', '
    Число жертв непогоды в Приволжском федеральном округе выросло до десяти человек, 76 пострадали. «Всего в результате прохождения опасных метеорологических явлений на территории Приволжья погибли 10 человек, пострадали 76», — заявили в министерстве. Отмечается, что порывы ветра в данном регионе могут достигать 27 м/с.
  ', 1690711800, 'https://lenta.ru/news/2023/07/30/10/', -8007568221165815631);
INSERT INTO public."NewsRss" VALUES (68990, 'Британцев предупредили о предстоящей сложной зиме и подорожании энергоносителей', '
    Компания  Energy UK — британский поставщик энергии предупредил жителей Великобритании о предстоящей тяжелой зиме. В компании отмечают, что предстоящая зима будет тяжелой для домохозяйств и предприятий острова из-за возможного роста цен на энергоносители. В Energy UK призывают продумать механизмы для поддержки клиентов.
  ', 1690711140, 'https://lenta.ru/news/2023/07/30/britain/', -3917610402139533198);
INSERT INTO public."NewsRss" VALUES (68991, 'Гладков сообщил о 80 ударах ВСУ по Белгородской области за сутки', '
    За прошедшие сутки украинские военные обстреляли территорию Белгородской области не менее 80 раз. Об этом говорится в сводке, опубликованной Telegram-канале губернатора региона Вячеслава Гладкова. Ни в одном из перечисленных населенных пунктов не было пострадавших, добавил он.
  ', 1690711080, 'https://lenta.ru/news/2023/07/30/87575/', -6644548099379621642);
INSERT INTO public."NewsRss" VALUES (68992, 'В Совфеде назвали цель атак ВСУ на Москву и Крым', '
    Украина пытается атаковать российские территории для того, чтобы скрыть неудачи в зоне специальной военной операции. Такую цель атак Киева назвал сенатор Совфеда Сергей Цеков. По мнению парламентария, ВСУ терпят неудачи на поле боя, поэтому им нужно продемонстрировать «хоть какую-то активность». 
  ', 1690710780, 'https://lenta.ru/news/2023/07/30/sovfeddd/', -6998594710283195503);
INSERT INTO public."NewsRss" VALUES (68993, 'Зеленскому предсказали войну из-за нежелания проводить выборы', '
    Украина может столкнуться с гражданской войной, если ее власти решает не проводить выборы, отмененные в стране из-за режима военного положения. Об этом заявил Олег Соскин, экс-советник бывшего президента республики Леонида Кучмы. Он считает, что действующий глава государства Владимир Зеленский потеряет легитимность.
  ', 1690710660, 'https://lenta.ru/news/2023/07/30/zel_ua/', -3717856159776934800);
INSERT INTO public."NewsRss" VALUES (68994, 'Интерес Украины к атакам на Крым объяснили', '
    Украина регулярно наносит удары беспилотниками по Крыму, чтобы еще сильнее обострить ситуацию, считает председатель комитета Совета Федерации по международным делам Григорий Карасин. Так в разговоре с «Лентой.ру» он объяснил интерес Киева к постоянным атакам полуострова.
  ', 1690710600, 'https://lenta.ru/news/2023/07/30/karasin/', -1972055468268496466);
INSERT INTO public."NewsRss" VALUES (68995, 'Врач оценил тренировки Костомарова на протезах', '
    Главный врач частной скорой помощи в Санкт-Петербурге Лев Авербах оценил тренировки олимпийского чемпиона в танцах на льду Романа Костомарова на протезах. «Костомарову еще предстоит много работы, работать надо будет всю жизнь, чтобы поддерживать свои протезы в порядке и функциональности», — отметил он.
  ', 1690710540, 'https://lenta.ru/news/2023/07/30/kostomarov/', 6622662795354493020);
INSERT INTO public."NewsRss" VALUES (68996, 'Молдавские фермеры пожаловались на проблемы из-за украинского зерна', '
    Молдавские фермеры пожаловались на проблемы из-за украинского зерна и попросили власти создать экспортный коридор для своей продукции. Отмечается, что на юге страны приходится стоять в очереди 5-6 дней, чтобы вывезти зерно, все сложности с логистикой экспортеры компенсируют за счет аграриев снижением закупочных цен. 
  ', 1690710300, 'https://lenta.ru/news/2023/07/30/moldavia_koridor/', -6870184189080907942);
INSERT INTO public."NewsRss" VALUES (68997, 'Пятеро россиян избили на посту сотрудников ДПС и сбежали', '
    В Краснодарском крае возбуждено уголовное дело о применении насилия в отношении представителей власти при исполнении служебных обязанностей. . Полицейские потребовали убрать машину, но водитель и четверо его пассажиров напали на полицейских. Избив сотрудников, они скрылись с места происшествия. 
  ', 1690709880, 'https://lenta.ru/news/2023/07/30/izbivateli/', -2882305976307316867);
INSERT INTO public."NewsRss" VALUES (68998, 'Стало известно о новом пострадавшем в результате обстрела ВСУ Брянской области', '
    В результате обстрела сельхозпредприятия в Климовском районе Брянской области есть еще один пострадавший — это мужчина, которому уже оказывают медицинскую помощь. Об этом сообщил глава приграничного российского региона Александр Богомаз. Он также заявил, что в результате атаки пострадали две женщины. 
  ', 1690709580, 'https://lenta.ru/news/2023/07/30/857/', -6614002129475029896);
INSERT INTO public."NewsRss" VALUES (68999, 'Глава СК взял на контроль расследование дела об отравлении детей в лагере Алтая', '
    Глава Следственного комитета России (СКР) Александр Бастрыкин взял на контроль расследование дела об отравлении детей в лагере «Горный Орленок» на Алтае. Бастрыкин поручил руководителю следственного управления республики предоставить доклад о ходе расследования всех установленных обстоятельств.
  ', 1690709460, 'https://lenta.ru/news/2023/07/30/altau/', -6654736433031405322);
INSERT INTO public."NewsRss" VALUES (69000, 'Появилось видео последствий атаки беспилотников на башни «Москва-Сити»', '
    В результате атаки беспилотников на деловой центр «Москва-Сити» в ночь на 30 июля были выбиты окна небоскреба на 11-м этаже. Видео с последствиями опубликовал Telegram-канал Shot. О взрывах в «Москва-Сити» стало известно около трех часов ночи 30 июля. Информацию позднее подтвердил мэр Москвы Сергей Собянин.
  ', 1690709381, 'https://lenta.ru/news/2023/07/30/bpla_posledstviya/', 5029013816128757793);
INSERT INTO public."NewsRss" VALUES (69001, 'Путин анонсировал пополнение российского флота', '
    В 2023 году состав Военно-морского флота (ВМФ) России пополнят три десятка кораблей. Об этом сообщил президент Владимир Путин. «Сегодня Россия уверенно реализует масштабные задачи национальной морской политики, последовательно наращивает мощь своего флота», — отметил он.
  ', 1690709160, 'https://lenta.ru/news/2023/07/30/flot_new/', 2433965311798287523);
INSERT INTO public."NewsRss" VALUES (69002, 'Украинец погиб в ДТП с казахскими туристами в Турции', '
    Два человека погибли во время ДТП в турецкой Анталье с участием грузовика и автобуса, который перевозил казахских туристов. По данным журналистов, одним из погибших оказался гражданин Украины, другим — водитель-турок. Еще 12 человек пострадали. Авария произошла в районе поселка Окурджалар. 
  ', 1690709100, 'https://lenta.ru/news/2023/07/30/ua_kaz/', -3714404890166313504);
INSERT INTO public."NewsRss" VALUES (69003, 'Правительство выступило против выхода России из МВФ', '
    Правительство России выступило против предложенной КПРФ идеи о выходе России из Международного валютного фонда (МВФ). Авторы законопроекта предлагали денонсировать протокол о вступлении страны в члены МВФ, Международной ассоциации развития, а также Международного банка реконструкции и развития.
  ', 1690708980, 'https://lenta.ru/news/2023/07/30/imf_stay/', -2865406071950458734);
INSERT INTO public."NewsRss" VALUES (69004, 'ВСУ нанесли удар по приграничному российскому региону', '
    Вооруженные силы Украины (ВСУ) нанесли удар по территории Климовского района Брянской области. По словам главы приграничного российского региона Александра Богомаза, снаряды попали на территорию свиноводческого комплекса. Он добавил, что на территории предприятия, куда попали снаряды, есть разрушения. 
  ', 1690708860, 'https://lenta.ru/news/2023/07/30/klimovskyy/', 7642658107683274827);
INSERT INTO public."NewsRss" VALUES (69005, 'Стало известно о подготовке Британией украинского спецназа к вторжению в Крым', '
    Британия готовит спецназ Вооруженных сил Украины (ВСУ) к вторжению в Крым до Рождества. Операция будет поддерживаться новым запасом ракет большой дальности, поставляемых из Великобритании, США и Германии, сообщает Daily Express со ссылкой на высокопоставленный британский военный источник.
  ', 1690708740, 'https://lenta.ru/news/2023/07/30/vtorzhneie/', -5872671720890188759);
INSERT INTO public."NewsRss" VALUES (69006, 'Увеличилось число пострадавших из-за ЧП с украинской ракетой в Таганроге', '
    Число пострадавших из-за ЧП с украинской ракетой в Таганроге увеличилось до 22 человек. Среди пострадавших есть ребенок. В министерстве региональной политики отметили, что, по состоянию на 30 июля, в больнице города остаются девять человек в состоянии средней степени тяжести.
  ', 1690707900, 'https://lenta.ru/news/2023/07/30/uvelichilos/', -2590574212779051787);
INSERT INTO public."NewsRss" VALUES (69007, 'Умер муж певицы Натали', '
    Муж российской певицы Натали музыкальный продюсер Александр Рудин умер в возрасте 53 лет. Об этом в воскресенье, 30 июля, сообщает KP.RU. Причина смерти не уточняется. При этом, по словам собеседников издания, Рудин не имел вредных привычек и не жаловался на здоровье. Продюсера похоронят в Дзержинске. 
  ', 1690707840, 'https://lenta.ru/news/2023/07/30/rudin/', -6651256019416911626);
INSERT INTO public."NewsRss" VALUES (69008, 'Число жертв урагана в Марий Эл выросло до восьми человек', '
    Жертвами урагана в Республике Марий Эл стали восемь человек, сообщил мэр Йошкар-Олы Евгений Маслов. «По последней информации, в Марий Эл из-за урагана, прошедшего накануне, погибли восемь человек», — заявил глава города. Маслов добавил, что десять человек госпитализированы, двое находятся в тяжелом состоянии.
  ', 1690707540, 'https://lenta.ru/news/2023/07/30/455854/', -3740351799006588848);
INSERT INTO public."NewsRss" VALUES (69009, 'Twitter разблокировал аккаунт Канье Уэста после обещания никого не оскорблять', '
    Соцсеть X, ранее известная как Twitter, восстановила страницу рэпера Канье Уэста спустя восемь месяцев после блокировки. Аккаунт артиста блокировали из-за нарушения правил компании — в частности, высказываний в адрес еврейской общины и слов, интерпретированных как побуждение к насилию. 
  ', 1690707422, 'https://lenta.ru/news/2023/07/30/kanye/', -6647674870497885962);
INSERT INTO public."NewsRss" VALUES (69010, 'В Италии предсказали «политическое решение» по украинскому кризису', '
    Исход украинского кризиса может быть определен политическим решением, а не ситуацией на поле боя, где Киева возникли объективные сложности. Об этом заявил министр обороны Италии Гуидо Крозетто. Российские укрепления, как полагает министр, серьезно осложняет попытки Вооруженных сил Украины добиться успехов на фронте.
  ', 1690706940, 'https://lenta.ru/news/2023/07/30/italy_ua/', -780647059443510123);
INSERT INTO public."NewsRss" VALUES (69011, 'В США рассказали об угрожающем Вашингтону «африканском поясе переворотов»', '
    Свержение президента Нигера Мохамеда Базума образовало в центральной Африке пояс стран от Гвинеи на западе до Судана на востоке, где были свергнуты избранные лидеры. Такие тенденции подрывают влияние в регионе США и открывают пути для России, считают в издании New York Times.
  ', 1690706460, 'https://lenta.ru/news/2023/07/30/usa_/', 2046116998993213108);
INSERT INTO public."NewsRss" VALUES (69012, 'Стало известно о проблемах у Грайнер после тюремного заключения в России', '
    Американская баскетболистка «Финикс Меркури» Бриттни Грайнер столкнулась с психологическими проблемами и пропустит несколько матчей WNBA. Спортсменку, признанную в России виновной в контрабанде наркотиков, 8 декабря 2022 года обменяли на россиянина Виктора Бута, осужденного в США.
  ', 1690706220, 'https://lenta.ru/news/2023/07/30/grainer/', -8596930432335572875);
INSERT INTO public."NewsRss" VALUES (69013, 'Путин заявил о нерушимости российского флота', '
    Президент Владимир Путин заявил о нерушимости российского флота. Об этом он сообщил, выступая на параде Военно-морского флота (ВМФ) в Санкт-Петербурге. «На протяжении веков наш флот был и остается нерушимым стражем рубежей Отечества, его гордостью и славой», — сказал глава страны.
  ', 1690705620, 'https://lenta.ru/news/2023/07/30/flot_russia/', 3198880842398408301);
INSERT INTO public."NewsRss" VALUES (69014, 'Польские футбольные фанаты устроили антиукраинскую акцию на матче', '
    Футбольные фанаты команды «Шленск» из города Вроцлав развернули на матче с «Заглембе» антиукраинские баннеры. На транспарантах были написаны оскорбления в адрес беженцев, властей, а также призывы «остановить украинизацию Польши». В кадр также попал баннер с лозунгом «80 лет позорного молчания за Волынь».
  ', 1690705440, 'https://lenta.ru/news/2023/07/30/pollandboll/', 294298104442600968);
INSERT INTO public."NewsRss" VALUES (69015, 'Брат Нурмагомедова рассказал о перенесенной из-за травмы операции', '
    Российский боец смешанного стиля Умар Нурмагомедов рассказал, что перенес операцию из-за травмы плеча. «Нет дороги назад. Пройду реабилитацию — и снова в бой», — написал он. В активе 27-летнего Нурмагомедова — 16 побед и ни одного поражения в MMA. В UFC он провел четыре боя.
  ', 1690704600, 'https://lenta.ru/news/2023/07/30/umar/', 2042862380687357620);
INSERT INTO public."NewsRss" VALUES (69016, 'Путину доложили о новой атаке беспилотников', '
    Президенту России Владимиру Путину доложили о новой атаке беспилотников на Московский регион. Об этом сообщил пресс-секретарь российского лидера Дмитрий Песков. Беспилотники атаковали район «Москва-Сити» в ночь на воскресенье, 30 июля. В результате атаки были незначительно повреждены фасады двух офисных башен.
  ', 1690704540, 'https://lenta.ru/news/2023/07/30/putin_knows/', -4375125872163257679);
INSERT INTO public."NewsRss" VALUES (69017, 'В России отреагировали на атаку беспилотников на «Москву-Сити»', '
    Ночная атака беспилотников на «Москву-Сити» стала беспрецедентной, полагает первый заместитель председателя комитета Госдумы по международным делам Светлана Журова. В разговоре с «Лентой.ру» парламентарий также высказалась об ответе на новые удары по российской столице.
  ', 1690704420, 'https://lenta.ru/news/2023/07/30/zhurova/', 1272364203015488900);
INSERT INTO public."NewsRss" VALUES (69018, 'Путин прибыл на парад ВМФ России', '
    Президент Владимир Путин прибыл на парад Военно-морского флота (ВМФ) России, глава государства находится в Петропавловской крепости. Отмечается, что политик пообщался с главой Минобороны России Сергеем Шойгу. Путин в этом году пригласил на парад лидеров стран Африки, которые приехали в Петербург для участия в саммите.
  ', 1690704300, 'https://lenta.ru/news/2023/07/30/vmfputin/', -4575633186943741806);
INSERT INTO public."NewsRss" VALUES (69019, 'Медведев предрек применение ядерного оружия при успехе контрнаступления ВСУ', '
    Россия была бы вынуждена применить ядерное оружие в случае, если бы контрнаступление Вооруженных сил Украины (ВСУ) оказалось успешным и привело бы к отторжению части российских территорий. Об этом в воскресенье, 30 июля, заявил зампред Совбеза РФ Дмитрий Медведев в своем Telegram-канале.
  ', 1690703760, 'https://lenta.ru/news/2023/07/30/prislosibi/', 6634579511619859080);
INSERT INTO public."NewsRss" VALUES (69020, 'В США назвали самый опасный истребитель России', '
    Российский истребитель пятого поколения Су-57 является самым опасным Воздушно-космических сил (ВКС) России. Наиболее ценные его характеристики – исключительная маневренность, высокая мощность ракет класса «воздух-воздух» Р-77М и Р-37М, а также доступ к широкому спектру классов крылатых ракет.
  ', 1690703160, 'https://lenta.ru/news/2023/07/30/su_57/', -6644303129595068170);
INSERT INTO public."NewsRss" VALUES (69021, 'Российские войска отразили семь атак ВСУ на территории ДНР', '
    Подразделения «Южной» группировки российских войск за сутки отбили семь атак Вооруженных сил Украины (ВСУ) на территории ДНР. Об этом сообщил на брифинге официальный представитель Минобороны Игорь Конашенков. Украинские подразделения пытались прорваться в районе Клещеевки, Андреевки и Красногоровки. 
  ', 1690702800, 'https://lenta.ru/news/2023/07/30/attak_vsu/', -3028957758671650696);
INSERT INTO public."NewsRss" VALUES (69022, 'В Минобороны заявили об уничтожении центра ремонта беспилотников ВСУ', '
    Российские военные уничтожили центр переучивания и пункт хранения, обслуживания и ремонта беспилотников Вооруженных сил Украины (ВСУ). Об этом 30 июля сообщили в Минобороны России. Удар был нанесен по объектам украинской армии, располагавшимся близ населенного пункта Могилевка в Днепропетровской области.
  ', 1690702800, 'https://lenta.ru/news/2023/07/30/centrbpla/', 4826911446540594205);
INSERT INTO public."NewsRss" VALUES (69023, 'ВС России отразили три атаки на краснолиманском направлении', '
    Вооруженные силы (ВС) России отразили три атаки на Красно-Лиманском направлении. Об этом сообщил на брифинге официальный представитель Минобороны Игорь Конашенков. Он добавил, что российские военные также нанесли удар по скоплениям живой силы и техники противника в районах нескольких населенных пунктов.
  ', 1690702740, 'https://lenta.ru/news/2023/07/30/brief/', -6648308481408175882);
INSERT INTO public."NewsRss" VALUES (69024, 'Стало известно об интересе клуба АПЛ к Мбаппе', '
    «Ливерпуль» заинтересовался форвардом «Пари Сен-Жермен» Килианом Мбаппе. Отмечается, что речь идет об аренде игрока на один сезон, что выгодно для французского клуба. Главным претендентом на 24-летнего Мбаппе остается мадридский «Реал», трансфер в который сорвался в 2022 году. 
  ', 1690702380, 'https://lenta.ru/news/2023/07/30/kilian/', -3716023374289031488);
INSERT INTO public."NewsRss" VALUES (69025, 'ВС России сбили украинский военный вертолет в ДНР', '
    Российские военные уничтожили вертолет Ми-8 Вооруженных сил Украины (ВСУ) на территории Донецкой народной республики (ДНР). Об этом сообщил на брифинге официальный представитель Минобороны Игорь Конашенков. По его словам, технику неприятеля сбила истребительная авиация ВКС России. 
  ', 1690701600, 'https://lenta.ru/news/2023/07/30/konashenkov/', 5799482221154700208);
INSERT INTO public."NewsRss" VALUES (69026, 'ВС РФ уничтожили пункт управления бригады украинской теробороны в ДНР', '
    Российские военные уничтожили пункт управления 100-й бригады украинской территориальной обороны. Об этом в воскресенье, 30 июля, сообщили в Минобороны России. Как уточнили в ведомстве, удар был нанесен по объекту близ населенного пункта Ямполь в Донецкой народной республике (ДНР).
  ', 1690701240, 'https://lenta.ru/news/2023/07/30/reroborona/', 3295157345501297336);
INSERT INTO public."NewsRss" VALUES (69027, 'В Минобороны заявили о продвижении ВС РФ в глубину обороны ВСУ', '
    Штурмовые отряды из «Западной» группировки войск Вооруженных сил России (ВС РФ) продолжили наступление на купянском направлении. Об этом в воскресенье, 30 июля, сообщило Минобороны России. Российские военные за минувшие сутки смогли продвинуться на 300 метров в глубину обороны ВСУ.
  ', 1690700940, 'https://lenta.ru/news/2023/07/30/vglubinu/', 4797531908062686844);
INSERT INTO public."NewsRss" VALUES (69028, 'Антарктида потеряла морской лед размером с Аргентину', '
    Антарктида потеряла морской лед размером с Аргентину, что стало неожиданностью для ученых. Его уровень упал до беспрецедентно низких значений за 45 лет, не вернувшись к ожидаемым показателям. Площадь льда примерно на 1,6 миллиона квадратных километров ниже предыдущего зимнего рекорда.
  ', 1690700400, 'https://lenta.ru/news/2023/07/30/antarktida/', 2030347585096081840);
INSERT INTO public."NewsRss" VALUES (69029, 'Самолет с отказавшим шасси приземлился в Москве', '
    В московском аэропорту Шереметьево приземлился пассажирский самолет с отказавшим шасси, который следовал из Улан-Удэ. Об этом в воскресенье, 30 июля, сообщает ТАСС со ссылкой на экстренные службы. Как уточнил собеседник агентства, самолет совершил благополучную посадку, несмотря на неисправность.
  ', 1690700160, 'https://lenta.ru/news/2023/07/30/shassi/', -3717158439285848000);
INSERT INTO public."NewsRss" VALUES (69030, 'В США рассказали об одной из основных улик против Трампа', '
    Долгое хранение президентом США Дональдом Трампом секретных документов станет одной из основных улик, которые могут использовать против него. Об этом заявил экс-агент ФБР Питер Страк. По его словам, добровольный возврат документов бывшим американским лидером как доказательство невиновности не избавит его от обвинений.
  ', 1690698960, 'https://lenta.ru/news/2023/07/30/trump_documents/', 3718813171120475782);
INSERT INTO public."NewsRss" VALUES (69031, 'В Запорожье сообщили о взятых в плен украинских военных', '
    Российские военные взяли в плен группу бойцов Вооруженных сил Украины (ВСУ) на Времевском выступе Запорожской линии фронта. Об этом в воскресенье, 30 июля, в беседе с РИА Новости сообщил председатель движения «Мы вместе с Россией» Владимир Рогов. «Взято много пленных противника», — заявил он.
  ', 1690698360, 'https://lenta.ru/news/2023/07/30/plenn/', -6651260355743149834);
INSERT INTO public."NewsRss" VALUES (69032, 'Киев в ночь на 30 июля предпринял массированную атаку беспилотниками на Крым', '
    Киев в ночь на 30 июля организовал атаку на объекты в Крыму с помощью 25 беспилотников, все они были поражены. По данным оборонного ведомства, террористическую атаку пытались осуществить с помощью беспилотников самолетного типа по объектам на территории полуострова. Силы ПВО сбили 16 беспилотников, 9 подавили РЭБ. 
  ', 1690698360, 'https://lenta.ru/news/2023/07/30/bplacrymea/', 165747146788588288);
INSERT INTO public."NewsRss" VALUES (69033, 'Гейджи победил Порье и завоевал пояс «Самого опасного ублюдка» UFC', '
    Американский боец смешанного стиля (ММА) Джастин Гейджи победил Дастина Порье в главном событии 291-го номерного турнира Абсолютного бойцовского чемпионата (UFC). Поединок завершился нокаутом во втором раунде. Благодаря победе Гейджи завоевал пояс «Самого опасного ублюдка» промоушена.
  ', 1690697820, 'https://lenta.ru/news/2023/07/30/nockout/', -6506529037240245879);
INSERT INTO public."NewsRss" VALUES (69034, 'Стало известно о повреждениях башен «Москва-Сити» в результате атаки БПЛА', '
    Три украинских беспилотника в ночь на 30 июля совершили атаку на Москву, сообщил в Telegram-канале мэр столицы Сергей Собянин. В результате были повреждены фасады на двух офисных башнях делового центра «Москва-Сити». Жертв и пострадавших нет. Об атаке стало известно приблизительно в три часа ночи 30 июля
  ', 1690695792, 'https://lenta.ru/news/2023/07/30/atakabesp/', -7714231929665982844);
INSERT INTO public."NewsRss" VALUES (69035, 'Военные России сорвали попытку переброски резервов ВСУ на купянском направлении', '
    Российские военные сорвали попытку переброски резервов Вооруженных сил Украины (ВСУ) на передовые позиции на купянском направлении в районе Новоселовского, об этом сообщил начальник пресс-центра группировки «Запад» полковник Сергей Зыбинский. Артиллеристы нанесли огневое поражение противнику.
  ', 1690694779, 'https://lenta.ru/news/2023/07/30/kupyanskoe/', -4529971764067956618);
INSERT INTO public."NewsRss" VALUES (69052, 'В США раскрыли Зеленскому главный секрет русских', '
    Экс-советник главы Пентагона Дуглас Макгрегор раскрыл президенту Украины Владимиру Зеленскому главный секрет русских: они борются за выживание, поскольку в случае поражения Запад лишит Россию всех ресурсов, назначив своих ставленников. Он полагает, что граждане России осознают возможность подобной угрозы.
  ', 1690686420, 'https://lenta.ru/news/2023/07/30/macgregor/', -2378808053047642681);
INSERT INTO public."NewsRss" VALUES (69053, 'Момент прилета БПЛА в «Москва-сити» попал на видео', '
    Момент прилета беспилотного летательного аппарата (БПЛА) в районе «Москва-сити» попал на видео регистратора проезжающего мимо авто. Кадры опубликовал Telegram-канал Mash. Первым об атаке на башню «Москвы-сити» сообщил Telegram-канал SHOT. Отмечалось, что предварительно, в здание влетел беспилотник, произошел взрыв.
  ', 1690686240, 'https://lenta.ru/news/2023/07/30/bplaaaa/', -3915801156220198126);
INSERT INTO public."NewsRss" VALUES (69054, 'Аэропорт Внуково возобновил работу на прилеты и вылеты', '
    Источники в авиационных службах рассказали, что московский аэропорт Внуково возобновил работу. Они уточнили, что в воздушной гавани осуществляются вылеты и прилеты. «Аэропорт возобновил свою работу», — подчеркнул источник. Ранее аэропорт Внуково закрыли на фоне атаки украинских дронов. 
  ', 1690686000, 'https://lenta.ru/news/2023/07/30/vnuk/', 2039736182194108084);
INSERT INTO public."NewsRss" VALUES (69055, 'Вблизи атакованной беспилотниками «Москвы-Сити» перекрыли движение', '
    Столичный Дептранс сообщил о перекрытии движения по Тестовской улице вблизи «Москвы-Сити», которая была атакована беспилотниками утром 30 июля. «Движение по Тестовской улице перекрыто. Пожалуйста, выбирайте пути объезда», — говорится в сообщении. Ранее информацию об атаке в столице подтвердил мэр Сергей Собянин.
  ', 1690685820, 'https://lenta.ru/news/2023/07/30/deptrans/', 1030165255494045247);
INSERT INTO public."NewsRss" VALUES (69056, 'В Запорожье рассказали о новом прозвище Зеленского', '
    Председатель запорожского движения «Мы вместе с Россией» Владимир Рогов рассказал о новом прозвище президента Украины Владимира Зеленского. Его назвали «слугой Ирода» после гонений на православие в стране. В качестве примера чиновник привел подписанный Зеленским закон о переносе празднования Рождества.
  ', 1690685400, 'https://lenta.ru/news/2023/07/30/rogov_ze/', -6945856627661061855);
INSERT INTO public."NewsRss" VALUES (69057, 'В США заявили о потере Зеленским доверия Запада', '
    Профессор Сиракузского университета Шон Макфейт заявил, что президент Украины Владимир Зеленский теряет доверие Запада, который начал разочаровываться в действиях Киева. По его словам, украинский лидер оказался в затруднительном положении, поскольку он не может позволить себе проиграть, но и победить не в состоянии.
  ', 1690685160, 'https://lenta.ru/news/2023/07/30/doverie/', 2859374553392189831);
INSERT INTO public."NewsRss" VALUES (69058, 'Последствия атаки беспилотников на «Москву-Сити» попали на видео', '
    Последствия атаки беспилотников на «Москву-Сити» попали на видео, кадры опубликовал SHOT. Взрывом выбило окна на 11 этаже. Обломки беспилотника и стекла лежат около входа в здание. Отмечается, что пострадавших нет. На месте работают экстренные службы. Ранее информацию об атаке подтвердил мэр Москвы Сергей Собянин.
  ', 1690684800, 'https://lenta.ru/news/2023/07/30/posl/', 2038596681927292596);
INSERT INTO public."NewsRss" VALUES (69059, 'Аргентина присоединилась к американской лунной программе', '
    Аргентина присоединилась к международной лунной программе Artemis, возглавляемой США. Об этом сообщает SpaceNews. Соглашение подписал министр науки, технологий и инноваций Аргентины Даниэль Филмус. Соответствующая церемония состоялась 27 июля в канцелярии президента страны в Буэнос-Айресе.
  ', 1690684643, 'https://lenta.ru/news/2023/07/30/artemis/', 7399460449512120432);
INSERT INTO public."NewsRss" VALUES (69060, 'В Московской воздушной зоне ввели временное ограничение на полеты', '
    В Московской воздушной зоне ввели временное ограничение на полеты любых воздушных судов. Об этом сообщает ТАСС со ссылкой на экстренные службы. Отмечается, что в нее входят сама Москва и Московская область. Ранним утром 30 июля в башню «Москвы-сити» попал украинский беспилотник.
  ', 1690684560, 'https://lenta.ru/news/2023/07/30/polety/', -3715183722141476208);
INSERT INTO public."NewsRss" VALUES (69061, 'Стал известен масштаб разрушений в башне «Москвы-Сити» после атаки дрона', '
    Площадь обрушения остекления башни «IQ квартала» в Москве составила 20 квадратных метров, рассказали источники. «Площадь обрушения остекления на башне "IQ квартала" составляет 20 квадратных метров, а на автомойке CrystalCity — 40 "квадратов"», — говорится в сообщении.
  ', 1690684200, 'https://lenta.ru/news/2023/07/30/bashna_/', -3923365823669016158);
INSERT INTO public."NewsRss" VALUES (69062, 'Минобороны заявило о пресечении террористической атаки БПЛА на Москву', '
    Министерство обороны России сообщило, что была пресечена попытка террористической атаки украинскими беспилотными летательными аппаратами на Москву. В ведомстве уточнили, что два БПЛА подавили средства радиоэлектронной борьбы (РЭБ), после чего они потеряли управление и потерпели крушение на территории «Москвы-Сити».
  ', 1690684020, 'https://lenta.ru/news/2023/07/30/mo/', -8024979812425369423);
INSERT INTO public."NewsRss" VALUES (69063, 'В башню «Москвы-сити» попал украинский беспилотник. Что известно на данный момент?', '
    Ранним утром 30 июля в башню «Москвы-Сити» попал украинский беспилотник. Информацию об атаке подтвердил мэр столицы Сергей Собянин. По его словам, пострадавших нет, здания получило незначительные разрушения. Аэропорт Внуково в Москве закрыт для прилетов и вылетов, сообщили в авиационных службах.
  ', 1690683600, 'https://lenta.ru/news/2023/07/30/ataka/', -6649443334084353802);
INSERT INTO public."NewsRss" VALUES (69064, 'Киев предупредили о необходимости срочно добиться результатов контрнаступления', '
    Обозреватель The Telegraph Роберт Кларк предупредил, что Вооруженным силам Украины (ВСУ) нужно как можно быстрее захватить Мелитополь, поскольку в скором времени начнется распутица, в результате которой земля на востоке страны превратится в болото, что значительно затруднит продвижение украинских войск и техники.
  ', 1690683300, 'https://lenta.ru/news/2023/07/30/results/', -3913562231958343815);
INSERT INTO public."NewsRss" VALUES (69065, 'Аэропорт Внуково закрыли на прилет и вылет', '
    Источники рассказали, что московский аэропорт Внуково закрыт на вылет и прилет. По их данным, рейсы перенаправляются в другие воздушные гавани. «Один рейс находится в зоне ожидания», — подчеркнул источник. Кроме того, он добавил, что задержано 16 рейсов на прилет и четыре — на вылет.
  ', 1690682220, 'https://lenta.ru/news/2023/07/30/vnukovo/', 9052367743484510255);
INSERT INTO public."NewsRss" VALUES (69066, 'Момент прилета беспилотника по башне «Москвы-Сити» попал на видео', '
    Момент прилета беспилотника по башне «Москвы-Сити» попал на видео, кадры опубликовал Telegram-канал «112». На записи виден мощный взрыв, который последовал после того, как БПЛА взрезался в здание. Ранее мэр Москвы Сергей Собянин подтвердил атаку украинских беспилотников на «Москву-Сити». 
  ', 1690681680, 'https://lenta.ru/news/2023/07/30/prilet/', -3712111051357001072);
INSERT INTO public."NewsRss" VALUES (69067, 'В Подмосковье камеры зафиксировали работу системы ПВО по беспилотникам', '
    В городе Одинцово Московской области камеры видеонаблюдения зафиксировали работу системы противовоздушной обороны по беспилотникам. На кадрах видно припаркованные машины. Доносится резкий и громкий звук взрыва. Ранее сообщалось, что беспилотники сбили в Подмосковье вблизи Одинцова и Красногорска. 
  ', 1690681200, 'https://lenta.ru/news/2023/07/30/odintsovo/', 6394737158021978617);
INSERT INTO public."NewsRss" VALUES (69068, 'На Вашингтон обрушилась гроза с порывами ветра до ста километров в час', '
    В Вашингтоне гроза с порывами ветра до ста километров в час обесточила множество домов и повалила деревья. Ураган сопровождался сильным ливнем, он повалил десятки деревьев, повредил постройки, автомобили. Без света остались 200 тысяч пользователей. Сведений о пострадавших в настоящее время не поступало.
  ', 1690680969, 'https://lenta.ru/news/2023/07/30/groza/', -6649437045805186826);
INSERT INTO public."NewsRss" VALUES (69069, 'Собянин заявил об отсутствии разрушений и пострадавших при атаке БПЛА в Москве', '
    Мэр Москвы Сергей Собянин подтвердил атаку украинских беспилотников на «Москву-Сити». «Сегодня ночью совершена атака украинских беспилотников. Незначительно повреждены фасады на двух офисных башнях Сити», — уточнил глава города. По словам Собянина, жертв и пострадавших нет. Ранее стало известно об эвакуации из башни.
  ', 1690680660, 'https://lenta.ru/news/2023/07/30/sobyanin/', -7002791970934954415);
INSERT INTO public."NewsRss" VALUES (69070, 'Один человек пострадал при попадании беспилотника в башню «Москвы-сити»', '
    В результате взрыва из-за попадания беспилотного летательного аппарата (БПЛА) в одну из башен «Москвы-сити» пострадал один человек. По данным Telegram-канала «112», пострадал один из охранников здания. Взрыв произошел примерно в три часа ночи и разбудил жителей соседних домов.
  ', 1690680622, 'https://lenta.ru/news/2023/07/30/postradal/', -3223513490341647348);
INSERT INTO public."NewsRss" VALUES (69071, 'В башне Москвы-сити началась эвакуация', '
    В 50-этажной башне IQ-квартала в «Москва-Сити» началась эвакуация, об этом сообщает SHOT. Ранее стало известно, что башню «Москвы-сити», предварительно, влетел беспилотник, произошел взрыв.По информации Telegram-канала Mash, над зданием виден дым, на место прибыли экстренные службы.
  ', 1690680360, 'https://lenta.ru/news/2023/07/30/evac/', 2036476501861398196);
INSERT INTO public."NewsRss" VALUES (69072, 'Опубликованы кадры прилета беспилотника в одну из башен «Москвы-Сити»', '
    Беспилотник врезался в одну из башен «Москвы-Сити», видео очевидцев появилось в сети. «Кадры последствий прилета беспилотника в одну из башен "Москвы-Сити". По официальным данным, беспилотный летательный аппрат (БПЛА) врезался в районе 6-7 этажей здания», — указано в подписи к ролику.
  ', 1690679940, 'https://lenta.ru/news/2023/07/30/city/', 2042093208506267316);
INSERT INTO public."NewsRss" VALUES (69073, 'Трамп призвал ладить с обладающей большим количеством ядерного оружия Россией', '
    Бывший президент США Дональд Трамп на митинге сторонников в штате Пенсильвания выступил с призывом налаживать отношения с Россией, у которой, по его словам, больше ядерного оружия, чем у Соединенных Штатов. По его словам, Вашингтон находится в глупой и опасной ситуации.
  ', 1690679880, 'https://lenta.ru/news/2023/07/30/nuclear/', -6507253278850943895);
INSERT INTO public."NewsRss" VALUES (69074, 'Стало известно о врезавшемся в башню «Москвы-Сити» беспилотнике', '
    В башню «Москвы-Сити», предварительно, влетел беспилотник, произошел взрыв. Об этом сообщает Telegram-канал «112». «Жители Москвы и области сообщают о взрывах. На кадрах одна из башен «Москва-Сити». Предварительно, в нее влетел беспилотник», — говорится в сообщении. На есто прибыли экстренные службы.
  ', 1690679040, 'https://lenta.ru/news/2023/07/30/bashnya/', -3915790738309453406);
INSERT INTO public."NewsRss" VALUES (69075, 'На крыше штаб-квартиры Twitter установили букву X', '
    Новый логотип в виде буквы «Х» установили на крыше штаб-квартиры Twitter в Сан-Франциско,сообщил владелец соцсети Илон Маск. «Наша штаб-квартира сегодня вечером в Сан-Франциско», — написал предприниматель. Администрация города Сан-Франциско начала расследование в отношении компании из-за металлической конструкции.
  ', 1690678756, 'https://lenta.ru/news/2023/07/30/xtwitter/', -2295042936190141899);
INSERT INTO public."NewsRss" VALUES (69076, 'Система ПВО сбила несколько беспилотников в Подмосковье', '
    Системы противовоздушной обороны (ПВО) сбили несколько беспилотников в Подмосковье вблизи Одинцова и Красногорска, сообщает SHOT. «В Подмосковье ПВО отразила атаки беспилотников на столицу, сообщили в экстренных службах. Звуки взрывов были слышны над городом Одинцово», — говорится в сообщении.
  ', 1690678740, 'https://lenta.ru/news/2023/07/30/besp/', 2043170709495150260);
INSERT INTO public."NewsRss" VALUES (69077, 'Число погибших от урагана в Марий Эл возросло', '
    В Марий Эл 24 человека пострадали при падении деревьев во время урагана, семеро погибли. Об этом сообщает Правительство Республики. 29 июля поступила информация о падении деревьев около озера Яльчик в Волжском районе и около озера Таир в Звениговском районе из-за непогоды. 
  ', 1690677000, 'https://lenta.ru/news/2023/07/30/maryel/', -3716192385297175712);
INSERT INTO public."NewsRss" VALUES (69078, 'На Украине сообщили о взрывах в Херсоне', '
    Украинское издание «Зеркало недели» сообщило о взрывах в подконтрольном Киеву Херсоне. В регионе объявлена воздушная тревога. Сигналы также звучат в Днепропетровской и Николаевской областях. Воздушные силы Украины заявили об угрозе использования ударных беспилотников в Херсонской области. 
  ', 1690676953, 'https://lenta.ru/news/2023/07/30/kherson/', -1972049283092691554);
INSERT INTO public."NewsRss" VALUES (69079, 'Экс-разведчик заявил о приказе США завершить контрнаступление ВСУ на фоне неудач', '
    Экс-разведчик ВС США Скотт Риттер заявил о завершении контрнаступления Украины из-за неудач на фронте. По его словам, обещания Киева прорваться к Азовскому морю и заставить Россию капитулировать силой западного оружия не были выполнены, поэтому Соединенные Штаты заявили, что «все кончено».
  ', 1690676280, 'https://lenta.ru/news/2023/07/30/ritter/', -3711442473395668496);
INSERT INTO public."NewsRss" VALUES (69080, 'В России выросло производство спортивной обуви', '
    В России на 65 процентов вырос объем производства спортивной обуви. Об этом пишет «Известия». По данным издания, в 2022 году в стране выпустили 168 миллионов пар. В 2023 году за пять месяцев объем изготавливаемой обуви составил 79 миллионов пар — на 16,6 процента больше, чем за аналогичный период 2022-го. 
  ', 1690676151, 'https://lenta.ru/news/2023/07/30/sportbuv/', 6757516573579787443);
INSERT INTO public."NewsRss" VALUES (69081, 'В США рассказали об унижении российскими войсками уникальной бригады ВСУ', '
    Впервые захваченная российскими военными боевая машина пехоты (БМП) CV90 использовалась «уникальной шведской» 21-ой бригадой Вооруженных сил Украины (ВСУ), на вооружении которой находится около 50 единиц данного вида техники. Отмечается, что украинские бойцы угодили в ловушку.
  ', 1690673820, 'https://lenta.ru/news/2023/07/30/bmp/', -6602784053391870856);
INSERT INTO public."NewsRss" VALUES (69082, 'В Севастополе рассказали о провокации в городе накануне Дня ВМФ', '
    Губернатор Севастополя Михаил Развожаев заявил, что пожилой мужчина разбил бутылку с зажигательной смесью у здания военной комендатуры в Севастополе. Как уточнил губернатор, злоумышленнику 63 года. «Разбил бутылку с зажигательной смесью рядом с военной комендатурой на Ленина», — указал он.
  ', 1690672500, 'https://lenta.ru/news/2023/07/30/guber_/', -3728239735663729280);
INSERT INTO public."NewsRss" VALUES (69083, 'Трамп обвинил Байдена в растрате денег налогоплательщиков на Украину', '
    Бывший глава Белого дома республиканец Дональд Трамп заявил, что администрация американского президента Джо Байдена тратит на Украину миллиарды долларов налогоплательщиков. Выступая перед сторонниками в штате Пенсильвания, он уточнил, что Байдены получили миллионы долларов от Украины. 
  ', 1690671360, 'https://lenta.ru/news/2023/07/30/bbiden_/', -3923358691157800078);
INSERT INTO public."NewsRss" VALUES (69084, 'О готовности России к столкновению с НАТО, успехах в ходе СВО и зерновой сделке: главное из выступления Путина', '
    Президент России Владимир Путин дал большую пресс-конференцию по итогам саммита «Россия — Африка» в Санкт-Петербурге. В ходе выступления глава государства высказался о готовности России к столкновению с НАТО, успехах в ходе специальной военной операции и зерновой сделке, а также об отношениях с Африкой.
  ', 1690670760, 'https://lenta.ru/news/2023/07/30/putin_press/', -4375131598157065551);
INSERT INTO public."NewsRss" VALUES (69085, 'Жители Татарстана остались без электроснабжения из-за урагана', '
    Жители нескольких районов Татарстана, включая Казань, сообщили о падении деревьев и нарушении электроснабжения из-за сильного ветра, передает Telegram-канал ГУМЧС России по Татарстану. Вечером 29 июля поступило 38 сообщений о падении деревьев в Лаишевском, Пестречинском, Зеленодольском и других районах.
  ', 1690670606, 'https://lenta.ru/news/2023/07/29/uragannn/', 22265876265157776);
INSERT INTO public."NewsRss" VALUES (69086, 'КНДР впервые показала подводный беспилотник «Хиэль-1»', '
    КНДР впервые показала ядерный подводный беспилотник «Хиэль-1» на военном параде в Пхеньяне по случаю 70-й годовщины окончания Корейской войны. Четыре подводных аппарата провезли на тягачах. Длина подводного аппарата может составить не менее 10 метров, а диаметр — около 1,5 метра.
  ', 1690670521, 'https://lenta.ru/news/2023/07/30/underwater/', -4871488817924070986);
INSERT INTO public."NewsRss" VALUES (69087, 'Шойгу отметил ключевую роль ВМФ в обеспечении суверенитета и свободы России', '
    Министр обороны России Сергей Шойгу поздравил военнослужащих и ветеранов с днем Военно-морского флота (ВМФ), отметив, что он играет ключевую роль в обеспечении суверенитета и свободы страны. По словам Шойгу, личный состав обладает современными знаниями и навыками управления сложной морской техникой.
  ', 1690670068, 'https://lenta.ru/news/2023/07/30/vmf/', -6611122628244097928);
INSERT INTO public."NewsRss" VALUES (69088, 'В Сербии предрекли Зеленскому потерю президентского кресла', '
    В Сербии заявили, что неблагодарность украинского президента Владимира Зеленского и его непонимание своего колониального статуса заставляет Запад искать ему замену в Киеве. Автор указал, что высказывания о неблагодарности Зеленского — только верхушка айсберга недовольства, которое царит среди союзников. 
  ', 1690669860, 'https://lenta.ru/news/2023/07/30/zelen_/', -3728221868461689744);
INSERT INTO public."NewsRss" VALUES (69089, 'Путин высказался об отказе ФРГ от российского газа', '
    Президент РФ Владимир Путин заявил, что отказ Германии от атомной энергии, угля и российского газа можно считать действиями малообразованных людей. «Посмотрите, что малообразованные люди делают в Германии», — отметил он. По словам Путина, политика ФРГ привела к росту цен на традиционные энергоносители. 
  ', 1690667820, 'https://lenta.ru/news/2023/07/30/putinn/', -3716030452220003696);
INSERT INTO public."NewsRss" VALUES (69090, 'Путин раскрыл причины своей выносливости', '
    Президент России Владимир Путин раскрыл причины своей выносливости, объяснив ее биологией и отметив, что она досталась ему от предков. Он добавил, что пока не планирует отдохнуть и не знает, удастся ли ему это, однако выразил надежду, что такой интенсивности в ближайшее время уже не будет.
  ', 1690667282, 'https://lenta.ru/news/2023/07/30/vynoslivy/', 6455407132906883149);
INSERT INTO public."NewsRss" VALUES (69091, 'Путин предостерег от использования неонацизма против России', '
    Президент РФ Владимир Путин предостерег страны от использования неонацизма против Москвы, заявив, что он вернется обратно к ним, как когда-то произошло при попытках использовать против России «Аль-Каиду» (террористическая организация, запрещена в РФ) во время войны на Кавказе.
  ', 1690667248, 'https://lenta.ru/news/2023/07/30/neonacizm/', -5189969942388643332);
INSERT INTO public."NewsRss" VALUES (69092, 'Путин прокомментировал аресты Кагарлицкого и Беркович', '
    Президент России Владимир Путин заявил, что никогда не слышал фамилий арестованных в России политолога Бориса Кагарлицкого (признан в РФ иноагентом) и режиссера Евгении Беркович. Он заявил, что не знает, «что они сделали, что с ними сделали» и допустил, что они не заслуживают того, как с ними поступили.
  ', 1690666770, 'https://lenta.ru/news/2023/07/30/kagarlicky_berkovich/', 1340116084058255139);
INSERT INTO public."NewsRss" VALUES (69093, 'Путин оценил угрозу нацбезопасности Украины и России', '
    Президент России Владимир Путин заявил, что можно наблюдать угрозу национальной безопасности Украины, но российской — нет. Его слова приводит ТАСС: «Угрозу национальной безопасности Украины мы видим, но это не наше дело. Угрозу нашей национальной безопасности не видим, но, судя по всему, к этому дело не идет».
  ', 1690666469, 'https://lenta.ru/news/2023/07/30/ukrandrussia/', -3234338732985593456);
INSERT INTO public."NewsRss" VALUES (69094, 'Путин ответил на вопрос «не 37-й ли год у нас»', '
    Президент РФ Владимир Путин объяснил некоторые аресты в России тем, что страна находится в состоянии вооруженного конфликта. «У нас 2023 [год], и Российская Федерация находится в состоянии вооруженного конфликта с соседом. На Украине за это расстреливают, ну не за это, а за подобное», — подчеркнул глава государства.
  ', 1690665900, 'https://lenta.ru/news/2023/07/30/putin_aresty/', -6628757172112172958);
INSERT INTO public."NewsRss" VALUES (69095, 'На Украине потребовали отстранить проигравшую Харлан российскую саблистку', '
    Украинская федерация фехтования обратилась в Международную федерацию фехтования (FIE) с требованием отстранить российскую спортсменку Анну Смирнову от соревнований. На Украине заявили, что спортсменка должна быть лишена нейтрального статуса. По их мнению, Смирнова демонстрирует поддержку российской армии.
  ', 1690665584, 'https://lenta.ru/news/2023/07/30/smirnova/', -4262490610043602686);
INSERT INTO public."NewsRss" VALUES (69096, 'Путин сообщил об ударах по местам производства БПЛА на Украине', '
    Президент РФ Владимир Путин заявил, что Россия нанесла удары по местам, где производились беспилотные летательные аппараты (БПЛА), которыми Киев бил по Крымскому мосту. «Как раз по тем местам, откуда направлялись эти беспилотники, и где они производились», — указал глава государства. 
  ', 1690665480, 'https://lenta.ru/news/2023/07/30/put_/', 2046139344041866932);
INSERT INTO public."NewsRss" VALUES (69097, 'Российский президент заявил о скорой нехватке рабочей силы на Украине', '
    Президент России Владимир Путин на пресс-конференции с журналистами предрек, что результаты сельскохозяйственного года на Украине окажутся ниже, чем в прошлые года, объяснив это большим количеством мобилизованных в стране, а также посетовал на то, что из-за этого в скором времени на Украине некому будет работать.
  ', 1690665210, 'https://lenta.ru/news/2023/07/30/rabota/', -3717857727576688144);
INSERT INTO public."NewsRss" VALUES (69098, 'Дрон-камикадзе «Ланцет» ВС РФ поразил украинскую «Гвоздику» и попал на видео', '
    Российский дрон-камикадзе «Ланцет» атаковал украинскую самоходную гаубицу «Ланцет». «На этот раз, "иксоводы" из 20-й армии Западного военного округа (ЗВО) поразили самоходную артиллерийскую установку 2С1 "Гвоздика" ВСУ восточнее насленного пункта Новомихайловка», — говорится в сообщении. 
  ', 1690664618, 'https://lenta.ru/news/2023/07/29/lanset_/', -34313920863987286);
INSERT INTO public."NewsRss" VALUES (69099, 'Путин оценил возможность перехода западных территорий Украины Польше', '
    Президент России Владимир Путин оценил нынешнюю ситуацию на Украине. Его слова приводит ТАСС: «Это может быть началом пути к отторжению западных территорий в пользу Польши». Также Путин подчеркнул: если на Украину будут введены польские войска — «это начало конца для части украинских территорий». 
  ', 1690664520, 'https://lenta.ru/news/2023/07/29/polshaput/', 1176946218540025870);
INSERT INTO public."NewsRss" VALUES (69100, 'Кожа в отпуске может испортиться. Как правильно за ней ухаживать, когда палит солнце? А что из косметички оставить дома?', '
    Состояние кожи — последнее, о чем задумываешься, собираясь в отпуск. Однако в отпуске кожа нуждается в особом уходе, поскольку ко всем обычным стресс-факторам добавляется еще один — палящее солнце. Эксперты рассказали «Ленте.ру», что обязательно должно быть в косметичке у тех, кто улетает на отдых.
  ', 1690664520, 'https://lenta.ru/news/2023/07/30/kosmetichka/', -5673733330656961554);
INSERT INTO public."NewsRss" VALUES (69101, 'Путин заявил об иссякающем на Украине мобилизационном ресурсе', '
    Президент России Владимир Путин заявил, что мобилизационный ресурс на Украине иссякает, заканчивается. Он отметил, что на Украине сформировали воинские подразделения из технического персонала для обслуживания самолетов и авиатехники. «Это говорит о чем? Мобилизационный ресурс иссякает, заканчивается», — подчеркнул он.
  ', 1690663958, 'https://lenta.ru/news/2023/07/29/rezerv/', -4101419479511107088);
INSERT INTO public."NewsRss" VALUES (69102, 'На Крымском мосту повысят меры безопасности', '
    Президент России Владимир Путин рассказал, что ему передали планы о повышении мер безопасности Крымского моста. Глава государства отметил, что планируется повысить техническую и физическую защиту сооружения. Он выразил уверенность в том, что технологии, предложенные специалистами по данному вопросу, окажутся надежными.
  ', 1690663920, 'https://lenta.ru/news/2023/07/29/crimea_bridge/', 6900184065330018934);
INSERT INTO public."NewsRss" VALUES (69103, 'Путин объяснил передачу иностранных активов во временное управление', '
    Президент России Владимир Путин заявил, что новых решений о передаче во временное управление иностранных активов не намечается. Его слова приводит ТАСС% «Предыдущие [решения] — не отъем собственности». Также Путин отметил, что Россия настроена дружелюбно к иностранным компаниям, которые хотят работать в стране.
  ', 1690663471, 'https://lenta.ru/news/2023/07/29/putin110/', 2261163653417793764);
INSERT INTO public."NewsRss" VALUES (69104, 'Президент России анонсировал встречу с Эрдоганом', '
    Президент России Владимир Путин на пресс-конференции с журналистами анонсировал встречу с турецким коллегой Реджепом Тайипом Эрдоганом. Он добавил, что лидеры двух государств хотели провести встречу еще до выборов в Турции, однако ее решили отложить с целью предотвратить возможные спекуляции.
  ', 1690663107, 'https://lenta.ru/news/2023/07/29/putin_erdogan/', -1404323233175675307);
INSERT INTO public."NewsRss" VALUES (69105, 'Путин заявил о готовности России к столкновению с НАТО', '
    Президент России Владимир Путин заявил, что Россия не хочет столкновения с НАТО, но готова в этому. Глава государства напомнил, что по инициативе США в свое время был разработал специальный механизм для предотвращения подобных конфликтов, имеется возможность напрямую обсудить кризисные ситуации.
  ', 1690662960, 'https://lenta.ru/news/2023/07/29/gotovy/', -4099047001181551232);
INSERT INTO public."NewsRss" VALUES (69106, 'Путин раскрыл детали проекта газвого хаба в Турции', '
    Президент России Владимир Путин заявил, что проект газового хаба в Турции предусматривает не хранение огромных объемов газа, а создание электронной торговой площадки. Глава государства раскрыл детали проекта газвого хаба. Он уточнил, что тема газового хаба в Турции остается на повестке дня. 
  ', 1690662360, 'https://lenta.ru/news/2023/07/29/gaz_pu/', -4101081660469435008);
INSERT INTO public."NewsRss" VALUES (69107, 'Путин объяснил связь зерновой сделки с мирным планом по Украине', '
    Президент России Владимир Путин заявил, что мирный план по Украине и зерновая сделка никак не связаны между собой. Его слова приводит ТАСС. «Да нет, одно с другим никак не связано», — подчеркнул российский глава. 17 июля официальный представитель Кремля Дмитрий Песков заявил, что Россия выходит из зерновой сделки.
  ', 1690662193, 'https://lenta.ru/news/2023/07/29/neuvidel/', 503125442555767119);
INSERT INTO public."NewsRss" VALUES (69108, 'Путин прокомментировал передачу бойцов «Азова» из Турции на Украину', '
    Президент России Владимир Путин прокомментировал передачу бойцов бригады «Азов» (запрещенная в России террористическая организация) на Украину. По его словам, договоренности с Турцией о нахождении этих лиц были. «Договоренности были, других комментариев не будет», — сказал он.
  ', 1690662120, 'https://lenta.ru/news/2023/07/29/azov/', -1630447384865473915);
INSERT INTO public."NewsRss" VALUES (69109, 'Путин призвал не считать спецоперацию корнем проблем на мировых рынках', '
    Президент России Владимир Путин призвал не считать спецоперацию на Украине корнем проблем на мировых рынках. Онзаявил, что западные страны на протяжении десятилетий раз за разом повторяли свои ошибки, исходя из внутриполитических соображений, а после начала СВО оказалось, что «удобно свалить» их на Россию.
  ', 1690661580, 'https://lenta.ru/news/2023/07/29/ne_svo/', -4106189498362140240);
INSERT INTO public."NewsRss" VALUES (69110, 'Путин рассказал об успехах российских войск в зоне СВО', '
    Президент России Владимир Путин заявил, что противник на Украине везде остановлен и отброшен. По словам главы государства, российская армия забирает нужные для Вооруженных сил РФ участки. Они продвинулись на 15 километров по фронту и на четыре километра в глубину, указал он. 
  ', 1690661520, 'https://lenta.ru/news/2023/07/29/pputtin_/', 6787675288152836435);
INSERT INTO public."NewsRss" VALUES (69111, 'Путин заявил об интересах стран Африки в космической сфере', '
    Президент России Владимир Путин заявил, что страны Африки интересуются космосом. Его слова приводит ТАСС. Ранее генеральный директор госкорпорации Юрий Борисов рассказал, что Россия вместо западных партнеров, отказавшихся от сотрудничества с «Роскосмосом» по ряду проектов, поищет новых.
  ', 1690661280, 'https://lenta.ru/news/2023/07/29/cosmosss/', -8461987362886697759);
INSERT INTO public."NewsRss" VALUES (69112, 'Путин оценил борьбу с последствиями пандемии коронавируса на Западе и в России', '
    Президент России Владимир Путин в ходе пресс-конференции по итогам саммита «Россия-Африка» оценил борьбу с последствиями пандемии коронавируса на Западе и в России. Он отметил, что западные страны «разбрасывали деньги» в борьбе с последствиями, допустив рекордную эмиссию, в то время как Россия действовала точнее.
  ', 1690661280, 'https://lenta.ru/news/2023/07/29/pandemia/', -6118264748302197479);
INSERT INTO public."NewsRss" VALUES (69113, 'Президент России рассказал потерянной в ходе контрнаступления технике ВСУ', '
    Президент России Владимир Путин назвал количество техники, потерянной Вооруженными силами Украины (ВСУ) в ходе контрнаступления. По его словам, с 4 июня Киев потерял 415 танков. Он добавил, что две трети потерянной в ходе боев техники Украине поставили западные государства.
  ', 1690661220, 'https://lenta.ru/news/2023/07/29/technique/', -2600549130252780457);
INSERT INTO public."NewsRss" VALUES (69114, 'Путин отказался считать своим делом управление войсками', '
    Президент России Владимир Путин заявил, что в курсе ситуации в зоне специальной военной операции, однако отказался считать своим делом управление войсками. «Я не считаю своим делом управление войсками, это неправильно и даже вредно», — отметил глава государства, добавив, что связывается с командирами, если это нужно.
  ', 1690660980, 'https://lenta.ru/news/2023/07/29/putin_voiska/', -3501690646219998178);
INSERT INTO public."NewsRss" VALUES (69115, 'Путин заявил о невозможности выполнить пункт о прекращении огня на Украине', '
    Российский президент Владимир Путин заявил, что Россия не может выполнить пункт о прекращении огня, так как Украина ведет крупномасштабное наступление. По его словам, есть вещи, которые труднореализуемы или нереализуемы. Одним из таких пунктов, по мнению главы государства, является прекращение огня. 
  ', 1690660860, 'https://lenta.ru/news/2023/07/29/pputin_/', -7816557625125285110);
INSERT INTO public."NewsRss" VALUES (69116, 'Путин рассказал о закупках африканскими странами оружия у России', '
    Президент России Владимир Путин рассказал, что африканские государства занимаются закупками у Москвы различных видов оружия. По его словам, при этом они не опасаются какого-либо давления со стороны Запада. Ранее глава государства рассказал, что провел откровенную и полезную дискуссию с африканскими лидерами.
  ', 1690660440, 'https://lenta.ru/news/2023/07/29/weapon_afr/', -487486086755236518);
INSERT INTO public."NewsRss" VALUES (69117, 'Путин вспомнил отношения России и Африки времен СССР', '
    Президент России Владимир Путин заявил, что в ходе отношений России и Африки сформировался задел прочности сотрудничества. Его слова приводит ТАСС. «В советское время было мнение, что зря тратили деньги на Африку, а сейчас с благодарностью об этом думаем — это задел прочности сотрудничества», — вспомнил Путин.
  ', 1690660380, 'https://lenta.ru/news/2023/07/29/usssr/', -8078146989325426438);
INSERT INTO public."NewsRss" VALUES (69118, 'Путин заявил об искреннем желании Африки закончить конфликт на Украине', '
    Президент России Владимир Путин заявил, что страны Африки хорошо относятся к Украине и искренне желают закончить конфликт в стране. Глава государства напомнил, что в то время, когда Советский Союз оказывал помощь африканским странам, Украина была его частью, к ней в целом относятся хорошо.
  ', 1690660380, 'https://lenta.ru/news/2023/07/29/afrika-ukraina/', 6963093390648987615);
INSERT INTO public."NewsRss" VALUES (69119, 'Путин рассказал об отношении африканских стран к России', '
    Президент РФ Владимир Путин заявил, что африканский континент настроен к России дружественно и положительно. Как рассказал политик, африканские государства «не просят подачек», а стараются найти, предлагают взаимовыгодные проекты. «Африканский континент к нам настроен в высшей степени дружественно», — отметил он. 
  ', 1690660140, 'https://lenta.ru/news/2023/07/29/putin_afrika_/', 6390158716393677715);
INSERT INTO public."NewsRss" VALUES (69120, 'Захарова прокомментировала переименование монумента «Родина-мать» в Киеве', '
    Официальный представитель МИД России Мария Захарова прокомментировала инициативу по переименованию монумента «Родина-мать» в Киеве. По ее словам, памятник переименуют, потому что не могут снести. «П — принципиальность. Если нельзя снести, то можно переименовать», — написала дипломат.
  ', 1690659909, 'https://lenta.ru/news/2023/07/29/zaxarova/', -6650237528048634951);
INSERT INTO public."NewsRss" VALUES (69139, 'Объем валютных вкладов россиян сократился', '
    По сравнению с февралем 2022 года этот показатель сократился вдвое — не 48,5 процента. «За первое полугодие 2023 года (вклады) сократились на 9,7 миллиарда долларов», — рассказал Осадчий. По мнению аналитика банка БКФ, главная причина снижения объема вкладов — ограничения, введенные в отношении Банка России. 
  ', 1690734840, 'https://lenta.ru/news/2023/07/30/valuta/', -3717857773074399440);
INSERT INTO public."NewsRss" VALUES (69143, '«Локомотив» разгромил «Факел» в матче РПЛ', '
    Московский «Локомотив» разгромил воронежский «Факел» в матче второго тура Российской премьер-лиги (РПЛ). Встреча прошла в Воронеже на «Центральном стадионе профсоюзов» и завершилась со счетом 4:1. В составе победителей отметились Артем Дзюба, Сергей Пиняев и Наир Тикнизян (дубль). 
  ', 1690734600, 'https://lenta.ru/news/2023/07/30/fak_lok/', 9054117282955553188);
INSERT INTO public."NewsRss" VALUES (69147, 'Певица Юлия Ковальчук показала фигуру после родов', '
    Российская певица Юлия Ковальчук показала фигуру спустя 20 дней после родов. Фотографией она поделилась на своей странице в соцсетях. Ковальчук сделала фото в зеркало. На нем она позирует в комплекте белья черного цвета. «Восстанавливаюсь, пока без занятий», — рассказала певица.
  ', 1690734240, 'https://lenta.ru/news/2023/07/30/shape_birth/', -6093045011567693122);
INSERT INTO public."NewsRss" VALUES (69151, 'Зеленский пригрозил препятствующим вступлению Украины в ЕС депутатам', '
    Президент Украины Владимир Зеленский призвал принять все законы, которые необходимые для открытия переговоров с Евросоюзом о вступлении туда республики, и пригрозил депутатам Верховной Рады, которые не поддержат их, негативными последствиями. «Или они за Украину, или им будет сложно на Украине», — подчеркнул политик. 
  ', 1690734214, 'https://lenta.ru/news/2023/07/30/otkazz/', -3714383167147878400);
INSERT INTO public."NewsRss" VALUES (69155, 'Учительницу русского языка задержали за брошенный в военкомат коктейль Молотова', '
    В Феодосии задержали 51-летнюю россиянку, бросившую коктейль Молотова в здание военкомата. Вечером 29 июля женщина достала из авоськи бутылку с зажигательной смесью и бросила в здание. До цели зажигательный заряд не долетел. От разлившейся горючей смеси загорелся асфальт и обувь диверсантки. 
  ', 1690734120, 'https://lenta.ru/news/2023/07/30/kokteyl/', -1971836533457919602);
INSERT INTO public."NewsRss" VALUES (69159, 'В работе Telegram произошел массовый сбой', '
    В работе мессенджера Telegram зафиксировали массовый сбой, свидетельствуют данные сервиса Downdetector. Согласно данным сервиса, пользователи начали жаловаться на работу мессенджера в районе шести часов вечера по московскому времени. 74 процента юзеров сообщают о проблемах с подключением сети и загрузкой контента. 
  ', 1690733040, 'https://lenta.ru/news/2023/07/30/telega/', -3717829490714379184);
INSERT INTO public."NewsRss" VALUES (69163, 'Карди Би бросила микрофон в зрителя на выступлении и попала на видео', '
    Американская рэп-исполнительница Карди Би бросила микрофон в зрителя во время выступления после того, как тот выплеснул на нее какой-то напиток. В субботу, 29 июля, в социальных сетях появился ролик, на котором видно, как на девушку во время выступления выплескивают некую жидкость из стакана. 
  ', 1690732500, 'https://lenta.ru/news/2023/07/30/877474/', -3740350883085714672);
INSERT INTO public."NewsRss" VALUES (69167, 'Актриса Папанова попала в аварию в Москве', '
    Заслуженная артистка России Елена Папанова попала в автомобильную аварию в Москве. В автомобиль 46-летней актрисы врезался в каршеринговый Volkswagen. Женщина ударилась головой о руль и получила травмы, но от госпитализации отказалась. 21-летний водитель Volkswagen, напротив, был госпитализирован.
  ', 1690732380, 'https://lenta.ru/news/2023/07/30/panova/', -3717854016611698032);
INSERT INTO public."NewsRss" VALUES (69171, 'Эксперт раскрыл секрет тренировок Райана Гослинга', '
    Фитнес-тренер Денис Соломин раскрыл секрет тренировок канадского актера Райана Гослинга. По его мнению, подобные тренировки помогают получить фигуру с сильной верхней частью тела, широкими плечами и стройными ногами. Отмечается, что четыре тренировки помогают росту мышечной массы, а две — поддержанию выносливости.
  ', 1690731960, 'https://lenta.ru/news/2023/07/30/gosling/', -8597954404403060347);
INSERT INTO public."NewsRss" VALUES (69477, 'ВСУ обстреляли артиллерией поселок в Белгородской области', '
    Вооруженные силы Украины (ВСУ) нанесли артиллерийский удар по поселку Прилесье в Краснояружском районе Белгородской Повреждены два частных жилых дома, в частности, пробита крыша и посечен осколками забор. Об этом сообщил губернатор Белгородской области Вячеслав Гладков. 
  ', 1690735260, 'https://lenta.ru/news/2023/07/30/zasq/', 2043364199139178164);
INSERT INTO public."NewsRss" VALUES (70811, 'Прохожие спасли едва не утонувшего в пруду Москвы мужчину', '
    На опубликованных кадрах можно заметить, что у берега плавают двое людей и просят прохожих помочь: третьего мужчины уже не видно над водой. К пруду бросился человек, который в итоге и вытащил пострадавшего. Слышно, как авторы видео возмущаются тому, что мужчина чуть не утонул «на ровном месте». 
  ', 1690736096, 'https://lenta.ru/news/2023/07/30/saved/', -6647569529981878026);
INSERT INTO public."NewsRss" VALUES (71071, 'Лопасти не удалось провернуть // Уход Vestas из России обернулся судами и уголовным делом', 'Как стало известно “Ъ”, попытка датского производителя комплектующих для ВИЭ Vestas уйти из РФ может обернуться долгими судебными тяжбами. Компания в 2022 году решила ликвидировать «Вестас Рус» и ВМ-Рус. Но вместо того чтобы расплатиться с кредиторами, «Вестас Рус» попыталась вывезти 60 лопастей для ветроэлектростанций на €10 млн. Часть из них была арестована в рамках уголовного дела, возбужденного после выхода Vestas из инвестсоглашения с РФ. Еще один спор возник вокруг долга Vestas перед «Вестас Рус». В рамках банкротства российской структуры управляющий хочет привлечь к ответственности акционеров Vestas и ликвидатора. Но исполнить решение суда будет сложно, говорят юристы.', 1690756237, 'https://www.kommersant.ru/doc/6135557', -2628464403391028301);
INSERT INTO public."NewsRss" VALUES (71073, 'Запад подтягивает к себе глобальный Юг // В Саудовской Аравии будут искать пути урегулирования между Москвой и Киевом без участия России', '5 августа в Саудовской Аравии соберутся представители десятков стран, которые будут решать, как запустить мирные переговоры по Украине. По данным западных СМИ, встреча будет организована по инициативе Киева и при поддержке Запада, а участвовать в ней приглашены не только союзники Украины, но и такие страны, как Бразилия, Индия, Египет, Индонезия и ЮАР. Россию на мероприятие не позвали. По замыслу организаторов, встреча в Джидде станет прологом к «саммиту мира», который, не называя даты, анонсировал президент Украины Владимир Зеленский. Саммит задуман как попытка сблизить западный и незападный взгляды на украинский кризис и пути его урегулирования. Судя по заявлениям президента ЮАР Сирила Рамафосы, прозвучавшим в Санкт-Петербурге, запрос на скорейшее окончание конфликта в мире нарастает.', 1690756237, 'https://www.kommersant.ru/doc/6135559', -3195917956439710797);
INSERT INTO public."NewsRss" VALUES (71075, 'В списках не назначиться // Госзаказ важнейших и дорогих лекарств остался почти без новинок', 'Необходимость экономии бюджетных средств может сказаться на расширении перечня лекарств, закупаемых по федеральным программам. С конца 2022 года Минздрав рекомендовал дополнить список жизненно необходимых и важнейших препаратов (ЖНВЛП) только одной позицией, а в список высокозатратных нозологий (ВЗН) не включил ни одно новое лекарство. Рассчитывавшие на госзаказ фармкомпании предупреждают об угрозе планам производства и повышении риска дефектуры в связи с неопределенностью.', 1690756237, 'https://www.kommersant.ru/doc/6135556', -2723039995565808717);
INSERT INTO public."NewsRss" VALUES (71079, 'Путешествуй, пока не началось // Компании Европы ждут мягкой рецессии и роста спроса на красивую жизнь', 'Европейский центральный банк (ЕЦБ) опубликовал итоги консультаций с крупными нефинансовыми компаниями зоны евро, менеджмент которых детализовал свои краткосрочные ожидания в отношении экономики ЕС в ближайшие месяцы. Риски рецессии на стыке 2023 и 2024 годов всеми считаются очень высокими. В промышленности наиболее проблемными считают себя строительство и сектор товаров промежуточного спроса, растут сектора, связанные с декарбонизацией. Компании отмечают перенос трат домохозяйств с товаров в сервисы, растущий спрос на путешествия, развлечения и цифровые сервисы, стабильность в ритейле. Снижение ценового давления, по оценкам компаний ЕС, продолжается, хотя рост зарплат в 2024 году не остановится.', 1690756237, 'https://www.kommersant.ru/doc/6135545', -2818020208019610701);
INSERT INTO public."NewsRss" VALUES (71083, 'Посольство РФ в США осудило Запад за стравливание братских народов', '
    Западные инсценировки, попытки стравливания братских народов и разобщения православных верующих продолжатся до достижения Россией всех целей СВО. Об этом заявило посольство РФ в США. Дипмиссия осудила вбросы американских СМИ, обвинивших Москву «в целенаправленном ударе по Спасо-Преображенскому кафедральному собору».
  ', 1690789622, 'https://lenta.ru/news/2023/07/31/celi_svo/', 612689707101187711);
INSERT INTO public."NewsRss" VALUES (71084, 'Обратная связь с лицензией // Правительство включит досудебное обжалование в процесс получения разрешений', 'Белый дом распространил механизм досудебного обжалования на сферу лицензионной деятельности — сервис жалоб на решения ведомств начал работать на портале госуслуг, рассказали “Ъ” в аппарате вице-премьера Дмитрия Григоренко. Механизм обжалования станет доступен по всем востребованным видам разрешений до октября и позволит собрать обратную связь от бизнеса для продолжения реформы разрешительной деятельности. В процессе ее оцифровки выяснилось, что не все предприниматели готовы получать документы в электронном виде.', 1690756237, 'https://www.kommersant.ru/doc/6135555', -2817615587740589133);
INSERT INTO public."NewsRss" VALUES (71089, 'Ипотека приблизилась к рекордным показателям // Мониторинг кредитования', 'К концу первой половины 2023 года на рынке жилищного кредитования наблюдалось заметное оживление — по данным ЦБ, в июне активность в этом сегменте достигла максимума с начала года. За месяц выдано 167,8 тыс. таких кредитов на 626,7 млрд руб., что является одним из самых исторически высоких показателей (больше было лишь в рекордном декабре 2022 года — 696,9 млрд руб. и в декабре 2021-го — 641,3 млрд руб.).', 1690756237, 'https://www.kommersant.ru/doc/6135546', -2723444615844830285);
INSERT INTO public."NewsRss" VALUES (71094, 'Сегодняшнее число', '39,1 процента, доля, которая приходилась на начало июня (по итогам мая 2023 года) на российский рубль во внешнеторговых расчетах РФ, видимо, является временным равновесным уровнем — он удерживается с осени 2022 года, сокращение доли «недружественных» валют, в основном доллара и евро, в расчетах происходит за счет роста доли «прочих» валют (на май 2023 года — более 26%), в этой категории растет доля китайского юаня. Это выводы анализа института BOFIT, констатирующего, что рост доли юаня, в отличие от контрактов в рубле, несет риски вторичных санкций. На прошлой неделе правительство предложило директивно перевести все расчеты РФ по агроэкспорту в рубль — это может стабилизировать долю юаня в расчетах.', 1690756237, 'https://www.kommersant.ru/doc/6135601', -2440208427664907341);
INSERT INTO public."NewsRss" VALUES (71099, 'Конкуренция средней тяжести // На губернаторские выборы в 21 регионе России выдвинулись от 4 до 12 кандидатов', 'В субботу в регионах, где пройдут прямые выборы губернаторов, завершился этап выдвижения кандидатов. Лидером по их количеству оказалась Москва, хотя 7 из 12 претендентов на мэрское кресло в итоге так и не сумели собрать подписи для регистрации. Минимальная конкуренция обнаружилась сразу в четырех регионах — в Тюменской, Магаданской и Кемеровской областях, а также на Чукотке, где поучаствовать в губернаторской гонке пожелали лишь по четыре кандидата.', 1690756237, 'https://www.kommersant.ru/doc/6135540', -2336135047890967629);
INSERT INTO public."NewsRss" VALUES (71104, 'Чтобы не мучились // Минприроды ищет способ избавить краснокнижных животных от страданий', 'Минприроды опубликовало проект изменений в правила умерщвления краснокнижных животных. Поводом для их отстрела может стать намерение «избавить особь от страданий», а сам процесс предлагают переименовать из «добывания» в «добычу». В экспертном сообществе указывают, что это два совершенно разных термина, причем новый опаснее для животных, а инициатива в целом может «развязать руки коррупционерам и охотникам».', 1690756237, 'https://www.kommersant.ru/doc/6135576', -2722793704961186893);
INSERT INTO public."NewsRss" VALUES (71109, 'Наблюдатели споткнулись о границы // У общественников и партийцев появились вопросы к экстерриториальным участкам', 'Общественная палата и партии ждут от Центризбиркома разъяснений, кто и как может наблюдать за выборами на экстерриториальных участках. Нововведение, которое позволит регионам создавать участки за границами своих избирательных округов, вводилось прежде всего для того, чтобы обеспечить голосование в новых субъектах РФ. Но внезапно обнаружилось, что оно плохо сочетается с запретом на так называемый электоральный туризм: речь идет о норме, которая позволяет становиться наблюдателями лишь тем гражданам, которые являются избирателями на данных выборах.', 1690756237, 'https://www.kommersant.ru/doc/6135542', -2525286232240528461);
INSERT INTO public."NewsRss" VALUES (71118, 'Два пассажира перевернувшегося на Волге катера с россиянами пропали без вести', '
    Катер с десятью россиянами попал в шторм и перевернулся на Волге в Чувашии. Как сообщает официальный Telegram-канал МЧС по региону, два пассажира, мужчина и восьмилетний мальчик, пропали без вести, а шестимесячную девочку спасти не удалось. Трагедия произошла во время сильной грозы вечером в субботу, 29 июля.
  ', 1690788873, 'https://lenta.ru/news/2023/07/31/volga/', 6248856420320489719);
INSERT INTO public."NewsRss" VALUES (71088, 'На Сахалине медведь забрался в пекарню и съел 125 пирожков', '
    В городе Оха на Сахалине медведь забрался в местную пекарню и съел более сотни пирожков. Об этом рассказали работницы предприятия на видео, которое публикует Telegram-канал «АСТВ.ру — новости Сахалина и Курил». На кадрах, снятых работающими в пекарне женщинами, видно, как животное поедает выпечку.
  ', 1690789505, 'https://lenta.ru/news/2023/07/31/pirozhki/', 8293950385697611092);
INSERT INTO public."NewsRss" VALUES (71091, 'Голливудский 386 — сериал Fubar', 'Голливудские хакеры и голливудские компьютеры вообще давно уже превратились в мем и надёжно прописались в голове у людей. Ко мне тут на днях подходили с просьбой увеличить видео и повернуть человека, стоявшего к камере спиной так, чтобы лицо можно было рассмотреть. Пришлось просителя огорчить. Впрочем, сейчас я не об этом. 



Тут на глаза попался новый нетфликсовский сериал Fubar со Шварценеггером, чем-то напоминающий «Правдивую ложь», растянутую на много серий. Сам сериал я не смотрел, так, мимо телевизора проходил, где его смотрели.

Клюквы в нём достаточно и так, но в шестой серии у героев стоит задача выбраться из старого советского бункера и при помощи старого советского компьютера. Посмотрим, на что способны голливудские хакеры сегодня. Читать дальше &rarr;', 1690773391, 'https://habr.com/ru/articles/751360/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751360', -1038280860394618972);
INSERT INTO public."NewsRss" VALUES (71093, 'Мужчинам раскрыли секреты питания для наращивания мышечной массы', '
    Сертифицированный диетолог, доктор медицинских наук Бриттани Данн раскрыла мужчинам главные правила питания, способствующие наращиванию мышечной массы. Она призвала их придерживаться сбалансированной диеты, в которой будет присутствовать достаточное количество белка, и соблюдать еще две рекомендации.
  ', 1690789440, 'https://lenta.ru/news/2023/07/31/men_buildmuscle/', 915871257050693014);
INSERT INTO public."NewsRss" VALUES (71098, 'В сети оценили откровенное видео Бузовой в душе фразой «не сексуально, а смешно»', '
    Российская ведущая и певица Ольга Бузова показала откровенное видео из душа, и поклонники оценили его фразой «не сексуально, а смешно». На размещенных кадрах 37-летняя исполнительница предстала в серебристом бикини, которое состояло из топа с треугольными чашками и трусов-танга. 
  ', 1690789425, 'https://lenta.ru/news/2023/07/31/bikinishower/', 5336412023733461359);
INSERT INTO public."NewsRss" VALUES (71103, 'У народной артистки Ирины Мирошниченко произошла остановка сердца', '
    У госпитализированной народной артистки России Ирины Мирошниченко произошла остановка сердца. Сообщается, что медикам удалось восстановить сердцебиение актрисы: она находится в реанимации, а ее состояние оценивается как тяжелое. Ранее у Мирошниченко диагностировали тяжелую форму гриппа.
  ', 1690789407, 'https://lenta.ru/news/2023/07/31/miroshnichenko_heart/', -2656783826948468233);
INSERT INTO public."NewsRss" VALUES (71106, 'Поиск кратчайшей траектории на поверхности реконструированного МРТ изображения', 'Привет, Хабр! Хочу рассказать о том, как я решал задачу связанную с обработкой и визуализацией томографических изображений, а именно —  измерение и поиск кратчайшей траектории на поверхности 3D изображения. Одна из областей применения  — измерение антропометрических данных на КТ/МРТ исследованиях. Читать далее', 1690729838, 'https://habr.com/ru/articles/688808/?utm_source=habrahabr&utm_medium=rss&utm_campaign=688808', -1037291769488896492);
INSERT INTO public."NewsRss" VALUES (71108, 'На Московском урбанфоруме пройдет благотворительный маркет', '
    На площадке Московского урбанистического форума в «Лужниках» пройдет благотворительный маркет с участием некоммерческих организаций (НКО) города. Гости  смогут приобрести вещи, сделанные руками подопечных НКО, все вырученные средства направят на помощь детям, людям старшего возраста, многодетным семьям и животным.
  ', 1690789217, 'https://lenta.ru/news/2023/07/31/market_muf/', -7369075544144548178);
INSERT INTO public."NewsRss" VALUES (71111, 'Аналитика небольших данных: как совместить Excel, Python и SQL с помощью инструментов с открытым исходным кодом', 'Как с помощью двух мощных инструментов с открытым исходным кодом можно совместить привычный для пользователей интерфейс, надежность и мощь SQL, гибкость Python и командную работу как в Google Spreadsheet? Читать далее', 1690736554, 'https://habr.com/ru/articles/751352/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751352', -1039157377320386652);
INSERT INTO public."NewsRss" VALUES (71113, 'Телеведущий рассказал о неприятном случае со звездой Comedy Club на съемках', '
    Психолог и ведущий шоу «Детектор» на телеканале «Пятница!» Марк Бартон рассказал о неприятном случае на съемках со звездой Comedy Club Тимуром Родригезом. Проект «Детектор» начал выходить на «Пятнице!» в феврале 2022 года. В программе знаменитости отвечают на личные вопросы, проходя проверку на полиграфе.
  ', 1690789072, 'https://lenta.ru/news/2023/07/31/barton/', -3662833476574797072);
INSERT INTO public."NewsRss" VALUES (71115, 'Черногория выбирает курс // Решается вопрос, станет ли новое правительство прозападным или наоборот', 'В понедельник в Черногории начинается формирование нового правительства по итогам прошедших в июне выборов. Имя будущего премьера известно — кабинет возглавит Милойко Спаич, лидер новой политической силы, движения «Европа сейчас». Политика же правительства будет зависеть от состава правящей коалиции: войдут ли в нее ориентирующиеся на ЕС партии нацменьшинств или же партии считающегося просербским и пророссийским «Демократического фронта». Многие эксперты и политики в Черногории убеждены, что расклад во многом определит ожидающаяся в ближайшие дни поездка будущего премьера в США. С подробностями из Подгорицы — корреспондент “Ъ” на Балканах Геннадий Сысоев.', 1690756237, 'https://www.kommersant.ru/doc/6135532', -2526394539961326669);
INSERT INTO public."NewsRss" VALUES (71120, 'Нагорнокарабахская проповедь // Сергей Строкань о главном камне преткновения в урегулировании армяно-азербайджанского конфликта', 'Новая война слов, разгорающаяся между сторонами армяно-азербайджанского конфликта после состоявшихся в Москве переговоров глав дипломатических ведомств двух стран, заставляет задуматься о том, что мешает заключению большого мирного договора между Ереваном и Баку. Главный камень преткновения — вопрос о том, как пройдет процесс вхождения непризнанной Нагорно-Карабахской республики в состав Азербайджана, одержавшего победу во второй карабахской войне.', 1690756237, 'https://www.kommersant.ru/doc/6135408', -3309406591721249869);
INSERT INTO public."NewsRss" VALUES (71125, 'Нефть прошла мимо рубля // Выручки от продажи энергоресурсов не хватает на поддержку российской валюты', 'Стоимость российской нефти Urals после шестимесячного перерыва приблизилась к $70 за баррель. За пять недель Urals подорожала почти на 30%, заметно опередив темпы роста Brent. В итоге дисконт к бенчмарку впервые с марта 2022 года опустился ниже $15 за баррель. Тенденция пока не отразилась на курсе рубля, хотя и привела к росту акций нефтяных компаний, подорожавших за неделю на 2,5–3,5%. Слабая реакция валютного рынка связана с активным переходом в ВЭД на рубли и валюты «дружественных» стран, а также усилившимся оттоком капитала.', 1690756237, 'https://www.kommersant.ru/doc/6135531', -2440826147041287245);
INSERT INTO public."NewsRss" VALUES (71130, 'Зерновики на Волге // Компании все активнее строят на реке экспортные терминалы', 'В Нижегородской области появится экспортный терминал для речной перевалки зерна на 300 тыс. тонн в год. Инфраструктура на Волге во времена СССР создавалась для приема импортного зерна. Сейчас приволжские регионы переориентируются на экспорт, а терминалы, которые исходно вводили в нижнем течении, начинают появляться и севернее. По мнению аналитиков, поставки зерна речным транспортом выглядят перспективными с учетом растущих отправок в Иран и возможностей рейдовой перевалки в Черном море.', 1690756237, 'https://www.kommersant.ru/doc/6135524', -2787233882441882701);
INSERT INTO public."NewsRss" VALUES (71155, 'Адвокат пациенток хирурга Хайдарова захотела привлечь его к ответственности', '
    Звездного пластического хирурга Тимура Хайдарова захотели привлечь к ответственности недовольные его работой пациентки. Юрист, представляющая интересы певицы Славы, подготовила коллективные заявления о проверке наличия составов преступлений в действиях Хайдарова, а также приближенных к нему лиц.
  ', 1690787580, 'https://lenta.ru/news/2023/07/31/advokathaid/', -8805678447832239466);
INSERT INTO public."NewsRss" VALUES (71161, 'Переписка про спамеров: избранное', 'Сотрудник ФАС, задремавший над спамом, в представлении художника эпохи романтизма

В предыдущих статьях (первая, вторая) я рассказывал, как спамеры и прочий «солидный бизнес», будучи пойманы за руку надзорным органом, начинают выкручиваться, отрицать очевидное, лгать и подделывать документы – в общем, вести себя как обычная шпана, пойманная за кражей яблок. Однако надзорный орган подчас даст фору самому изобретательному спамеру. Читать дальше &rarr;', 1690751198, 'https://habr.com/ru/articles/751362/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751362', -1039160469696839772);
INSERT INTO public."NewsRss" VALUES (71172, 'Сигары Фрейда или Факел свободы. Мы теряем половину нашего рынка', 'Работать всегда желательно с первоисточником. В обратном случае мы сталкиваемся с невежеством, Копенгагенскими интерпретациями, Пирамидами Маслоу и Сигарами Фрейда.&nbsp; Читать далее', 1690766194, 'https://habr.com/ru/articles/751372/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751372', -1039160813294223452);
INSERT INTO public."NewsRss" VALUES (71121, '[Перевод] Итак, вы установили fzf. Что дальше?', '
Разработчики ПО — если не единственные, то практически единственные, кому очень просто создавать инструменты для улучшения своей профессиональной работы; однако со временем это усложняет жизнь людям, постоянно переключающимся между разными инструментами и не вкладывающим время в глубокое изучение своего инструментария. Имея глубокое уважение к негласным знаниям людей лучше меня, я всё же считаю, что отличная эвристика 80/20 заключается в том, чтобы изучать старые добрые инструменты Unix cat, ls, cd, grep и cut. (а если вам повезло устроиться на должность настоящего современного сисадмина, то ещё и sed с awk.)

Однако существуют инструменты, выгода от использования которых настолько мгновенна и ценность от применения настолько уникальна, что эвристика 80/20 полностью к ним неприменима. Один из них — это fzf. И меня очень печалит то, что многие скачивают его, запускают в командной строке «как есть», а потом просто мотают головой и произносят: «Я не понимаю».

Мне хотелось бы изменить ситуацию. Предположим, что вы работаете на более-менее стандартной машине с Ubuntu. Вы только что установили fzf при помощи стандартного скрипта установки. Что же дальше? Читать дальше &rarr;', 1690787528, 'https://habr.com/ru/articles/724070/?utm_source=habrahabr&utm_medium=rss&utm_campaign=724070', -1038281216049844316);
INSERT INTO public."NewsRss" VALUES (71126, '[Перевод] Краткий пересказ вебинара про релиз YDB v23.1', 'Восемь разработчиков YDB собрались, чтобы поделиться тем, что они сделали для последнего релиза YDB v23.1. Рассмотренные новые возможности можно разделить на две категории: функциональные улучшения и улучшения производительности. Читать далее', 1690766337, 'https://habr.com/ru/companies/ydb/articles/751374/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751374', -8492215657254346867);
INSERT INTO public."NewsRss" VALUES (71133, 'Композиция математических объектов в рамках абстрактной модели мышления', 'АннотацияРассматривается структура основных математических объектов, опирающаяся на абстрактную модель разумного мышления. Каковая, в свою очередь, выводится из основополагающего высказывания "я мыслю, следовательно, существую''''. Показано, что данные аспекты математики взаимосвязаны и могут быть заданы только в рамках объединяющей теории.О чём это?"Куст есть совокупность растений, произрастающих из одной точки"(преподаватель военной кафедры МИРЭА, 1989 г.)Современная математика не целостна. Множества, числа, функции, геометрические примитивы, логические значения -- всё это абстракции, не имеющие общего родителя или родителей. Иными словами, наша математика -- не куст, а несколько отдельных растений. Отсутствие единой начальной точки приводит к интересным последствиям. Таким, например, как аксиома выбора, утверждающая существование функции, которая написана неизвестно как. Собственно, отсутствие описанной структуры объектов и вынуждает нас прибегать к аксиомам.Уже долгое время подобная ситуация воспринимается как нечто естественное...Хотя математика и управляет материальным миром (и вроде бы существует "сама по себе"), думать о математике может только человек -- субъект, обладающий разумным мышлением. Отыскание модели мышления -- и само по себе увлекательная и интересная задача; однако, выяснилось, что введение модели мышления в математику позволяет найти необходимую исходную "точку опоры" и сделать математику целостной.При этом модель мышления не изобретена, а открыта. Вы используете эту модель в настоящий момент, когда читаете этот текст. Она состоит из "доски" (экрана) и того средства, которым записан текст -- в работе оно называется "маркер". Как выяснилось, этого более чем достаточно. Если ваша способность читать и писать текст считается доказанной, то такова же и вся вытекающая из этой способности "низшая" математика.Объекты задаются одновременно графически и программно. Во всех случаях для объектов приводится их структура (из каких элементов состоит) и информация (как эти элементы расположены). А также обоснование необходимости этих объектов (к вопросу необходимости вообще особо тщательное отношение).Обнаруженная модель внезапно позволяет внести ясность в отдельные вопросы математики и доказать ряд важных утверждений о числах и множествах. Дочитать до конца и узнать подробности', 1690749001, 'https://habr.com/ru/articles/751058/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751058', -1037292617679274076);
INSERT INTO public."NewsRss" VALUES (71140, 'Как приручить облачного зверя: раскрываем тему FinOps', 'Закупать серверы или использовать «облако»? Какие риски есть в каждом из этих подходов? Как помирить тех, кто платит по счетам в компании и тех, кто может запустить дорогой ИИ-сервис на десять минут, забыть про него и обеспечить к концу месяца непредвиденные расходы организации?&nbsp;Облако даёт компаниям гибкость и мощность, но может легко выйти из-под контроля. Как приручить этого опасного зверя?&nbsp;В статье разберём:— Как взять облако под контроль и сделать расходы предсказуемыми.— Как FinOps помогает оптимизировать использование облачных сервисов.— Как избежать типичных ошибок и рисков при внедрении этой практики. Читать далее', 1690786801, 'https://habr.com/ru/companies/inferit/articles/751364/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751364', 3276061441060579998);
INSERT INTO public."NewsRss" VALUES (71145, 'Как саботировать внедрение темных паттернов', 'Примите куки, подпишитесь на рекламную рассылку, установите браузер «Амиго». Все эти действия требуют явного согласия пользователя, но UX таков, что пользователь со всем соглашается по умолчанию. А нас, работников IT, заставляют это разрабатывать. Попробуем разобраться можно ли что-то с этим сделать или же наша участь молчать и терпеть. Читать далее', 1690783201, 'https://habr.com/ru/articles/751144/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751144', -1039897835587797084);
INSERT INTO public."NewsRss" VALUES (71156, 'Илон Маск обижает старожила Твиттера, а вокруг сверхпроводников поднимается сверххайп', 'Почти все самые важные и интересные финансовые новости в России и мире за неделю: почему зарубежные бизнесы в РФ используют «стратегию опоссума», у QIWI-банка проблемы с ЦБ, Госдума борется с зарубежными адресами почты, а Сэм Альтман запустил&nbsp;«глазную»&nbsp;крипту.  Читать далее', 1690779418, 'https://habr.com/ru/articles/751388/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751388', -1037304356630200412);
INSERT INTO public."NewsRss" VALUES (71193, 'Из студийных глубин // Самые ожидаемые альбомы', 'До конца 2023 года меломанам предстоит оценить переработанную версию самого популярного альбома XX века, вспомнить о былом величии звезды арт-рока и станцевать вместе с самой экстравагантной певицей Англии. Все это уже стоит в графике музыкальных релизов, но кое-что еще наверняка добавится. Рассказывает Игорь Гаврилов.', 1690756237, 'https://www.kommersant.ru/doc/6135434', -2787604761457826893);
INSERT INTO public."NewsRss" VALUES (71195, 'На место в карьер // Завершился Авиньонский фестиваль', 'В Авиньоне завершился 77-й Festival d’Avignon. По традиции многие спектакли его программы игрались за пределами стен старого города. В поисках искусства Эсфирь Штейнбок вместе с другими зрителями проехалась по природным красотам в окрестностях фестивального центра.', 1690756237, 'https://www.kommersant.ru/doc/6135433', -2503877984933485645);
INSERT INTO public."NewsRss" VALUES (71199, 'Хорошо забытые дни // в мюзикле Коки Гидройч', 'В прокате музыкальная драмеди «Лучшие дни» Коки Гидройч — адаптация одноименного сценического мюзикла, составленного из песен группы Take That. Однако даже для тех, кто равнодушен к творчеству этого коллектива, фильм может стать источником чистой радости, слегка приправленной ностальгией, считает Юлия Шагельман.', 1690756237, 'https://www.kommersant.ru/doc/6135432', -2526395983070338125);
INSERT INTO public."NewsRss" VALUES (71123, '20-летняя россиянка ударила ножом мужчину в студии загара в Петербурге', '
    В Санкт-Петербурге полицейские возбудили уголовное дело о причинении тяжкого вреда здоровью. ЧП произошло в круглосуточной студии загара в Санкт-Петербурге. Около 7 утра находившаяся в помещении туалета 20-летняя безработная россиянка нанесла колото-резанное ранение в живот 29-летнего мужчины. 
  ', 1690788761, 'https://lenta.ru/news/2023/07/31/ponojovshina/', -6844069127231900134);
INSERT INTO public."NewsRss" VALUES (71128, 'Пропавшую в российском регионе семилетнюю школьницу нашли живой', '
    Семилетнюю девочку, которая пропала в Междуреченске в Кузбассе, нашли живой на одной из улиц. Об этом сообщили в пресс-службе регионального управления МВД России. В ведомстве уточнили, что поиски школьницы не прекращались всю ночь. В них принимали участие работники нескольких подразделений полиции и волонтеры. 
  ', 1690788443, 'https://lenta.ru/news/2023/07/31/kuzgirll/', 192093388443865284);
INSERT INTO public."NewsRss" VALUES (71135, 'Работающая в Китае русалкой россиянка рассказала об отношениях с акулой', '
    25-летняя Дарья из Краснодара, работающая русалкой в Китае, рассказала об отношениях с морскими животными. Девушка плавает под водой без маски и в специальном костюме, развлекая людей. По словам собеседницы «Ленты.ру», во время плавания с морскими животными происходит множество интересных случаев.
  ', 1690788300, 'https://lenta.ru/news/2023/07/31/mermaid_darya/', 1779722272762121134);
INSERT INTO public."NewsRss" VALUES (71134, 'Дистанционные территории // Подрядчик «Яндекса» набирает в Донецке и Луганске сотрудников для удаленной работы', 'На сервисе объявлений hh.ru появились вакансии редактора для нейросетей «Яндекса» и диспетчеров такси «Яндекс Go», рассчитанные на соискателей из Донецка и Луганска. В компании подтвердили “Ъ”, что один из ее партнеров по массовому найму опубликовал вакансии. Речь идет об удаленной работе — сам «Яндекс Go» в ДНР и ЛНР не действует.', 1690756237, 'https://www.kommersant.ru/doc/6135517', -2629238459576982605);
INSERT INTO public."NewsRss" VALUES (71138, 'Стало известно о вербовке СБУ жителей ДНР для совершения терактов', '
    Украинские спецслужбы вербуют жителей Донецкой народной республики (ДНР) для совершения диверсионно-террористических актов, заявил завербованный Службой безопасности Украины (СБУ) Евгений Иникин. Его задержали заключили под стражу в 2021 году в Днепре, годом позже выпустили уже в Мариуполе.
  ', 1690788240, 'https://lenta.ru/news/2023/07/31/sbuagent/', 559836773719505227);
INSERT INTO public."NewsRss" VALUES (71139, 'Люки в потолке // Татьяна Едовина о незапланированных последствиях ограничений на нефтеэкспорт России', 'Если в начале года аналитики делали осторожные оценки относительно того, насколько эффективным оказался ценовой потолок на поставки российской нефти, то теперь значимость этой меры отходит на второй план. Участников рынка вновь беспокоит его более широкая конъюнктура.', 1690756237, 'https://www.kommersant.ru/doc/6134885', -2814983428039089229);
INSERT INTO public."NewsRss" VALUES (71143, 'В Хабаровском крае прошел фестиваль удэгейской культуры', '
    Фестиваль-конкурс удэгейской культуры «Встреча сородичей» прошел в Хабаровском крае. Об этом сообщает «Российская газета» со ссылкой на минтуризма региона. Как отмечается, мероприятие провели в селе Гвасюги в рамках туристического проекта «Дни районов Хабаровского края».
  ', 1690788219, 'https://lenta.ru/news/2023/07/31/udeg/', 2037248050172327684);
INSERT INTO public."NewsRss" VALUES (71144, 'Официальные курсы ЦБ России на 29–31.07.2023', '#TABLE02: перейдите в режим FullText для редактирования таблицы#  *За 10. **За 100.', 1690756237, 'https://www.kommersant.ru/doc/6135605', -2818510796364029005);
INSERT INTO public."NewsRss" VALUES (71148, 'ВСУ обстреляли приграничный российский регион', '
    Вооруженные силы Украины обстреляли село Ломаковка Брянской области, повреждены четыре домовладения, сообщил губернатор Александр Богомаз. В результате атаки повреждены четыре домовладения и два автомобиля, в селе нарушено энергоснабжение. На месте происшествия работают экстренные службы.
  ', 1690788060, 'https://lenta.ru/news/2023/07/31/shelling/', -8800842229228072379);
INSERT INTO public."NewsRss" VALUES (71151, 'Индексы ведущих фондовых бирж 28.07.23', '#TABLE02: перейдите в режим FullText для редактирования таблицы#  По данным агентства Bloomberg.', 1690756237, 'https://www.kommersant.ru/doc/6135604', -2786985598972435533);
INSERT INTO public."NewsRss" VALUES (71157, 'ЦБ шифрует цифровой рубль // Новая стратегия защиты не спасет от социальной инженерии', 'Банк России определил, как кредитные организации должны будут защищать операции с цифровым рублем. По мнению экспертов, для небольших банков без филиалов затраты на организацию инфраструктуры могут достичь 100 млн руб. и вряд ли окупятся. При этом участники рынка отмечают, что предложенные регулятором меры будут малоэффективны против мошенничества, включая главную проблему финансового рынка — социальную инженерию.', 1690756237, 'https://www.kommersant.ru/doc/6135480', -2333110635000339533);
INSERT INTO public."NewsRss" VALUES (71160, 'Задержание троих россиян по делу о госизмене попало на видео', '
    ФСБ показала видео задержания троих жителей Воронежской области за госизмену. На кадрах видно, как бойцы спецслужбы ведут фигурантов в наручниках к служебному авто. Затем россияне дают признательные показания и рассказывают, как их завербовали в организацию «Правый сектор». 
  ', 1690787340, 'https://lenta.ru/news/2023/07/31/fsbsaderj/', 4411751235374839814);
INSERT INTO public."NewsRss" VALUES (71165, 'Россиян предупредили о резком подорожании шоколада', '
    Цены на какао-бобы взлетели до самого высокого уровня за десятилетие, что может привести к резкому подорожанию шоколада во всем мире, в том числе в России, предупреждают эксперты. 27 июля цена нью-йоркских фьючерсов на какао превысила 3,5 тысячи долларов за одну тонну, последний раз такое наблюдалось в 2011 году.
  ', 1690787280, 'https://lenta.ru/news/2023/07/31/choko/', 6246579049143156983);
INSERT INTO public."NewsRss" VALUES (71170, 'Рождаемость на Украине сократилась почти на треть', '
    С начала специальной военной операции (СВО) рождаемость на Украине сократилась на 28 процентов: за полгода в стране родились 47 129 девочек и 49 626 мальчиков. Отрицательные демографические показатели на Украине фиксируются с 2013 года, и рождаемость сокращалась приблизительно на семь процентов в ежегодно.
  ', 1690787100, 'https://lenta.ru/news/2023/07/31/rozhdaemist/', 4613042842465452703);
INSERT INTO public."NewsRss" VALUES (71178, 'Названа причина переноса боя Бетербиева с британцем Смитом', '
    Корреспондент ESPN Майк Коппинджер заявил, что бой Артура Бетербиева с британским боксером Каллумом Смитом отложили из-за проблем россиянина со здоровьем. Боксеру понадобится хирургическое вмешательство из-за инфекции костной ткани челюсти после лечения зубов. Поединок может состояться в начале 2024 года.
  ', 1690787040, 'https://lenta.ru/news/2023/07/31/beterbiev_smith/', -4178742182987677214);
INSERT INTO public."NewsRss" VALUES (71182, 'На кровать пенсионеров из российского города рухнул потолок', '
    В двухэтажном жилом доме в Хабаровске рухнул потолок. На кровать проживающих там пенсионеров посыпалась штукатурка и обвалилась крупная балка. Здание не входит в список аварийных, однако в июле владельцы одной из квартир обратились в УК с жалобой на трещину в потолке. Коммунальщики не стали заниматься проблемой.
  ', 1690787040, 'https://lenta.ru/news/2023/07/31/potolok/', -7807013376242421350);
INSERT INTO public."NewsRss" VALUES (71185, 'Офицер НАТО назвал эффективное оружие России против техники ВСУ', '
    Российские военные эффективно используют вертолет Ка-52 для остановки контрнаступления Вооруженных сил Украины. «Вертолет стал одним из самых эффективных благодаря своей прочной конструкции и атакующим возможностям», — подчеркнул Ставрос Атламазоглу. Также вертолеты сыграли важную роль в операции в Сирии. 
  ', 1690786560, 'https://lenta.ru/news/2023/07/31/ka52/', 2032747727082813188);
INSERT INTO public."NewsRss" VALUES (71188, 'На Западе оценили объем российского экспорта оружия в Африку и его перспективы', '
    Несмотря на падение продаж оружия из-за СВО на Украине, РФ по-прежнему один из главных экспортеров оружия в Африку, в ближайшие время предстоит увидеть итоги соглашений, подписанных на саммите Россия — Африка. Объем российского экспорта оружия в Африку и его перспективы оценил научный сотрудник RUSI Самуэль Рамани.
  ', 1690786560, 'https://lenta.ru/news/2023/07/31/5883389/', -3254983380416085279);
INSERT INTO public."NewsRss" VALUES (71189, 'Клиенты интим-салона попытались сбежать от полиции по крыше', '
    В Санкт-Петербурге полицейские обнаружили и закрыли интим-салон. В пятикомнатной квартире на Итальянской улице работали пять россиянок в возрасте от 19 до 38 лет, которыми руководила 50-летняя уроженка Всеволожска. Клиентами заведения являлись обеспеченные россияне и иностранные граждане. 
  ', 1690786380, 'https://lenta.ru/news/2023/07/31/klients/', -1967652053213183138);
INSERT INTO public."NewsRss" VALUES (71192, 'ФСБ задержала троих россиян по делу о госизмене', '
    ФСБ задержала троих россиян, передававших данные о российских военных объектах, Украине. Трое жителей Воронежской области передавали данные запрещенной в России экстремистской организации «Правый сектор». По факту произошедшего возбудили дело по статье 275 («Государственная измена») УК РФ. 
  ', 1690786260, 'https://lenta.ru/news/2023/07/31/fsbvsrf/', 9055906864465068484);
INSERT INTO public."NewsRss" VALUES (71197, 'Женщинам после 50 лет назвали здоровый способ похудеть', '
    Диетолог, врач спортивной медицины Екатерина Стрельникова рассказала женщинам, каким должно быть правильное питание после 50 лет. Чтобы похудеть и не растерять мышечную массу в зрелом возрасте, им надо употреблять меньше углеводов и следить за количеством жиров в рационе.
  ', 1690786150, 'https://lenta.ru/news/2023/07/31/nutrition50/', -4210354055326425371);
INSERT INTO public."NewsRss" VALUES (71163, 'ЦБ проехался по страховщикам // Количество претензий к ним резко возросло', 'ЦБ ужесточил контроль за страховщиками в сегменте ОСАГО. За семь месяцев число решений регулятора о привлечении компаний к административной ответственности из-за невозможности оформить полис или навязывания услуг выросло до рекордных значений за четыре года. По сравнению с объемами страхования количество нарушений незначительно, но, по мнению экспертов, для страховщиков оно может обернуться серьезными издержками на выплату штрафов или приостановкой лицензии.', 1690756237, 'https://www.kommersant.ru/doc/6135528', -3309651439216860237);
INSERT INTO public."NewsRss" VALUES (71169, 'Шины больше не роскошь // Их продажи в первом полугодии выросли на 5%', 'Продажи шин в РФ вышли в плюс на 5% по итогам полугодия за счет хорошего результата второго квартала, на который пришелся сезон смены резины. Легковые шины продолжают занимать основную долю рынка, но спрос на них в премиальном сегменте остается неудовлетворенным, констатируют производители. Ситуация вызвана уходом из РФ иностранных игроков — новые владельцы этих заводов только начинают выводить на рынок свои линейки шин. Пока же топ продаж занимают остатки западных марок и импорт из Китая.', 1690756237, 'https://www.kommersant.ru/doc/6135525', -2818759079833476173);
INSERT INTO public."NewsRss" VALUES (71173, 'Автокредиты переводят на китайский // Производители из КНР активно поддерживают финансирование продаж', 'Доля китайских марок в структуре выдач автокредитов по новым автомобилям приблизилась к 50%. Причина не только в уходе западных брендов, но и в том, что автоконцерны из КНР предлагают скидки, субсидии и варианты рассрочки при покупке автомобиля, а некоторые подпадают под госпрограммы льготного автокредитования. Впрочем, высокие цены и дефицит новых машин сохраняют значительную долю кредитов за автомобилями с пробегом, где представлены преимущественно российские и европейские марки.', 1690756237, 'https://www.kommersant.ru/doc/6135530', -2337243355611765837);
INSERT INTO public."NewsRss" VALUES (71177, 'Кибербезопасность уложили в пятилетку // Российский рынок набирает объем с уходом конкурентов', 'Объем российского рынка кибербезопасности в ближайшие несколько лет будет расти в среднем на 24% в год и к 2027 году составит 559 млрд руб., полагают в Центре стратегических разработок (ЦСР). Пока, несмотря на уход западных вендоров и импортозамещение, доля иностранных решений остается существенной: 30% по итогам 2022 года. По мнению ЦСР, она упадет до 5–8%, которые займут игроки из дружественных стран, в основном КНР. Участники рынка дают более консервативные оценки роста рынка, на 15–17% в год.', 1690756237, 'https://www.kommersant.ru/doc/6135518', -3309282003309927501);
INSERT INTO public."NewsRss" VALUES (71181, 'Оборудование загрузят на полигон // В РФ строят инфраструктуру для ускорения выпуска фотолитографов', 'Минпромторг, Минобрнауки, производители полупроводников и профильные вузы реализуют проект по строительству в РФ сети полигонов для тестирования оборудования для производства микроэлектроники, которое находится в разработке. Новая инфраструктура также нужна для обучения специалистов. Строительство одного полигона с учетом затрат на сложную инженерную инфраструктуру может стоить около 5 млрд руб. По оценке экспертов, использование тестовых полигонов примерно на год ускорит начало серийного выпуска установок.', 1690756237, 'https://www.kommersant.ru/doc/6135519', -3196692012625665101);
INSERT INTO public."NewsRss" VALUES (71184, 'Туристы потянулись в аптеки // Продажи солнцезащитной косметики восстанавливаются', 'Сократившийся в ходе пандемии почти вдвое оборот солнцезащитных средств восстановился до сравнимого с докризисным уровня. По итогам января—июня продажи такой косметики в аптеках выросли на 10,2%, до 985 млн руб., за счет роста цен и туристической активности. В то же время торговые сети отмечают переключение потребителей на более дешевые бренды, а аналитики допускают замедление продаж категории из-за «сложного сезона» в Крыму.', 1690756237, 'https://www.kommersant.ru/doc/6135514', -2786864446534949965);
INSERT INTO public."NewsRss" VALUES (71187, 'Апартаментская оппозиция // Застройщику не обанкротиться, покупателям не вселиться', 'На московском рынке недвижимости произошло прецедентное событие — суд остановил банкротство застройщика. Апелляция отменила решение суда первой инстанции в отношении девелопера одного из известных столичных долгостроев — апартаментов «Клубный дом "Октябрь"». Остановка конкурсного производства в отношении УК «Норд-Инжиниринг», рассчитывают инвесторы, позволит им получить в конце концов свои апартаменты. Но юристы указывают на туманность перспектив в силу неопределенности правового статуса этого типа жилья.', 1690756237, 'https://www.kommersant.ru/doc/6135513', -2503137670010608717);
INSERT INTO public."NewsRss" VALUES (71176, 'ChatGPT уже не тот? Тестируем 10 плагинов для чтения URL и грустим', 'Пользователи новой социальной сети Х говорят, что ChatGPT в последнее время сошёлся с инженером-химиком чудовщино поглупел, теряет пользователей и больше никому не нужен. Это правда так?&nbsp;Мы во фронтендерском подкасте «Про код» тоже случайно затронули этот вопрос, но в необычном ключе. Обсуждали пользу alt-текстов для SEO и между делом вспомнили про плагины, с помощью которых ChatGPT умеет читать веб-страницы, а не только постоянно вспоминать свой 2021 и жаловаться.Идея простая — если нейросети всерьёз пытаются заменить поисковики, то и искать они должны по всему, а не только по тому, что видно глазами. Ведь иногда то, что нарисовано на картинке, не описывается в тексте. Так что мы решили провести простой тест — скормить нейросети специально сконструированную страницу с alt-текстом и посмотреть, что будет. А так как у ChatGPT вышла масса плагинов для чтения сайтов, то заодно и их протестировать. Спойлер: всё хуже, можно было предположить, но лучик надежды брезжит. Читать далее', 1690781401, 'https://habr.com/ru/articles/751376/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751376', -1039512657015111772);
INSERT INTO public."NewsRss" VALUES (71191, 'Склады вернулись к спекулянтам // Доля строящихся не под заказ объектов может достичь 60%', 'Почувствовав предпосылки к оживлению рынка, девелоперы складской недвижимости сделали ставку на спекулятивные проекты. Доля строящихся не для конкретных арендаторов объектов в этом году может достичь 60–70%, став рекордной с 2018 года. Формат считается более рискованным, но за счет резко выросшего спроса и дефицита предложения обеспечивает застройщикам лучшие ставки аренды.', 1690756237, 'https://www.kommersant.ru/doc/6135516', -2723814051751763021);
INSERT INTO public."NewsRss" VALUES (71198, 'Оксана Самойлова резко отреагировала на критику стиля 12-летней дочери', '
    Российская блогерша и жена рэпера Джигана Оксана Самойлова резко отреагировала на слова хейтеров по поводу стиля старшей дочери Ариелы. Одна из подписчиц инфлюэнсера разместила упомянутое фото в собственном аккаунте, назвав образ подростка чересчур откровенным. «Идите *****», — ответила Самойлова.
  ', 1690786140, 'https://lenta.ru/news/2023/07/31/samoylovaariela/', -2961515691046802212);
INSERT INTO public."NewsRss" VALUES (71201, 'Прибывший в Грузию круизный лайнер с россиянами привел к протестам', '
    Прибывший в порт Батуми круизный лайнер с россиянами привел к акции протеста местных оппозиционеров. Судно со «Звездным круизом» зашло в порт Батуми утром в понедельник, 31 июля. Накануне там собрались грузинские оппозиционеры и активисты, которые хотели выразить протест. Полиция усилила меры безопасности.
  ', 1690785600, 'https://lenta.ru/news/2023/07/31/georgia/', -8599325392605761691);
INSERT INTO public."NewsRss" VALUES (71204, 'Российский пенсионер попытался сжечь военкомат из-за обвиняемых в госизмене', '
    В Архангельской области 76-летнего российского пенсионера задержали за попытку поджога военкомата. Во время обыска на компьютере обвиняемого нашли переписку с неким куратором, убедившего мужчину в том, что в здании находятся люди, участвующие в госизмене, которых необходимо наказать.
  ', 1690785600, 'https://lenta.ru/news/2023/07/31/bounec/', -3665368615986560272);
INSERT INTO public."NewsRss" VALUES (71206, 'Политолог объяснил нежелание Украины вести переговоры с Россией', '
    Украина избегает мирных переговоров с Россией из опасений, что Москва использует затянувшуюся паузу для нанесения нового удара, сообщил политолог и аналитик Стокгольмского центра восточноевропейских исследований Шведского института международных отношений Андреас Умланд.
  ', 1690785595, 'https://lenta.ru/news/2023/07/31/politologobjasnil/', -5397172856725648836);
INSERT INTO public."NewsRss" VALUES (71208, 'Россиян предупредили о замаскированных под настоящие мошеннических приложениях', '
    Количество фейковых приложений, ворующих персональные данные пользователей, выросло на 34 процента в первом полугодии 2023 года. Об этом в беседе с «Лентой.ру» заявил директор Центра Solar appScreener компании «РТК-Солар» Даниил Чернов, также предупредивший россиян о наиболее часто подделываемых приложениях.
  ', 1690785420, 'https://lenta.ru/news/2023/07/31/apps/', 2042415566955804420);
INSERT INTO public."NewsRss" VALUES (71210, 'Пушилин сообщил о вытеснении ВСУ из села Старомайорское в ДНР', '
    Солдаты Российской армии вытеснили подразделения Вооруженных сил Украины (ВСУ) из села Старомайорское Донецкой народной республики (ДНР), украинские части понесли значительные потери. Об этом сообщил врио главы ДНР Денис Пушилин. Ранее стало известно об отражении атаки ВСУ на населенный пункт.
  ', 1690785360, 'https://lenta.ru/news/2023/07/31/vsustaromayorsk/', -3206773134653533687);
INSERT INTO public."NewsRss" VALUES (71213, '«Челси» выразил готовность отдать ПСЖ компенсацию и игрока взамен Мбаппе', '
    Daily Record сообщает, что «Челси» готов заплатить ПСЖ денежную компенсацию за Мбаппе, а также отдать парижанам одного из игроков взамен форварда. Отмечается, что владелец «Челси» Тодд Боули уже обсудил это предложение с президентом ПСЖ Нассером Аль-Хелаифи и предположительно получил одобрение на ведение сделки.
  ', 1690785300, 'https://lenta.ru/news/2023/07/31/chelsea_psg/', 6778383491423339584);
INSERT INTO public."NewsRss" VALUES (71215, 'Стало известно о взрывах в Кривом Роге', '
    Мэр Кривого Рога Александр Вилкул сообщил о взрывах в городе. «Кривой Рог. Взрывы. Ничего не снимает и не выкладываем в интернет», — написал он. Ранее мэр Харькова Игорь Терехов сообщил, что в городе на месте «двух прилетов» произошел пожар. Ранее по всей Украине звучала воздушная тревога.
  ', 1690785120, 'https://lenta.ru/news/2023/07/31/krivoirog/', 5438141290171621241);
INSERT INTO public."NewsRss" VALUES (71217, 'Семь туристов пострадали при столкновении микроавтобуса с грузовиком на Алтае', '
    Семь туристов получили травмы во время столкновения микроавтобуса с грузовиком на Алтае. Уточняется, что сообщение о ДТП в Чемальском районе поступило в 10:06 в понедельник, 31 июля. Грузовой автомобиль «Асенизатор» HINO столкнулся с микроавтобусом Мерседес-Бенс «Спринтер». 
  ', 1690785120, 'https://lenta.ru/news/2023/07/31/altay/', 6246176543292268791);
INSERT INTO public."NewsRss" VALUES (71219, 'Таксисты в России попросили не заставлять их покупать отечественные автомобили', '
    Ассоциация «Национальный совет такси» (НСТ) попросила правительство не заставлять компании из сферы такси покупать только локализованные в России автомобили. В НСТ указали на дефицит российских авто, который сопровождается быстрым ростом цен. Новые меры приведут к подорожанию услуг такси для клиентом, указал бизнес.
  ', 1690784940, 'https://lenta.ru/news/2023/07/31/taksi/', 6248172781653741815);
INSERT INTO public."NewsRss" VALUES (71202, '«Краснодар» побудет «Зенитом» // В премьер-лиге появился новый лидер', 'Единоличным лидером чемпионата России с шестью очками стал «Краснодар», который в матче второго тура обыграл на своем поле «Сочи» — 2:0. Первые победы одержали «Локомотив» и ЦСКА. Красно-зеленые притушили «Факел» — 4:1, а красно-синие перебили в своеобразной серии пенальти «Ахмат» — 3:2.', 1690756237, 'https://www.kommersant.ru/doc/6135448', -3308914010512006221);
INSERT INTO public."NewsRss" VALUES (71205, '«Манчестер Юнайтед» взял пример с соседа // Он закрыл позицию центрфорварда юным датчанином Расмусом Хёйлунном', '«Манчестер Юнайтед» совершит один из самых дорогих и любопытных трансферов нынешнего лета. Он приобретает у итальянской «Аталанты» за сумму, превышающую &pound;70 млн, 20-летнего датского нападающего Расмуса Хёйлунна. Еще недавно мало кому известный футболист Хёйлунн резко поднял свои котировки в минувшие полтора сезона. Они заставили сравнивать его с норвежцем Эрлингом Холанном, который в «Манчестер Сити» превратился в эталонного центрфорварда.', 1690756237, 'https://www.kommersant.ru/doc/6135449', -3196324019827743821);
INSERT INTO public."NewsRss" VALUES (71207, 'Второй тур', '«Крылья Советов»—«Динамо» 3:3', 1690756237, 'https://www.kommersant.ru/doc/6135606', -2723935204189248589);
INSERT INTO public."NewsRss" VALUES (71209, 'Велика Африка, а отступать некуда-4 // Тылы президента России на военно-морском параде надежно прикрыли африканцы', '30 июля Верховный главнокомандующий Владимир Путин в Петербурге провел праздник, посвященный Дню Военно-Морского Флота. Специальный корреспондент “Ъ” Андрей Колесников — с подробностями о том, как продолжался и чем закончился, уже в Кронштадте, захватывающий четырехдневный питерский российско-африканский марафон.', 1690749512, 'https://www.kommersant.ru/doc/6135554', -2786090390348995661);
INSERT INTO public."NewsRss" VALUES (71211, 'Приемные семьи сделают вклад в банк данных // Совет федерации одобрил расширенный сбор информации о детях-сиротах', 'В банк данных о детях-сиротах будут вносить больше сведений о том, как они живут и воспитываются в приемной семье — в том числе информацию о физическом и эмоциональном здоровье. Такой закон в конце прошлой недели одобрил Совет федерации. Одни эксперты по опеке считают его прогрессивным и направленным на повышение уровня благополучия детей, оставшихся без попечения родителей. Другие называют его «ювенальным», усиливающим «слежку за семьями» — и уже просят президента отклонить инициативу. Впрочем, один из собеседников “Ъ” назвал поправки лишь «началом работы» по законодательному обеспечению социального сопровождения приемных семей.', 1690747611, 'https://www.kommersant.ru/doc/6135535', -2819128515740408909);
INSERT INTO public."NewsRss" VALUES (71212, 'Африке подкинут удобрений // Российские экспортеры намерены в разы увеличить поставки', 'Российские химические компании на фоне санкций намерены активизировать поставки в страны Африки, увеличив их в несколько раз за ближайшие пять лет. Правительства африканских государств рассчитывают не только импортировать готовую продукцию, но и создавать свои производства в партнерстве с поставщиками из РФ. Впрочем, те пока не проявляют к этому большого энтузиазма.', 1690743225, 'https://www.kommersant.ru/doc/6135521', -2440456711134354509);
INSERT INTO public."NewsRss" VALUES (71214, 'Летний отдых и вечный покой // Длинные школьные каникулы могут повышать смертность подростков в РФ', 'Сама по себе детская смертность в РФ невелика, но из-за чрезмерно длинных школьных каникул в летние месяцы в РФ растет число смертей среди детей и подростков, подсчитали в РАНХиГС. По их оценке, в летние месяцы показатель смертности для детей в возрасте 5–9 лет в среднем увеличивается на 21%, а для подростков (10–14 лет) — на 32%. Снижение смертности могло бы дать перераспределение образовательных программ в школах, может подействовать и упрощение подросткового трудоустройства.', 1690740917, 'https://www.kommersant.ru/doc/6135544', -2786495010628017229);
INSERT INTO public."NewsRss" VALUES (71220, 'Минфин назвал главную причину резкого ослабления рубля', '
    Глава Минфина России Антон Силуанов назвал главную причину резкого ослабления рубля — она заключается в изменении торгового баланса страны. Курс зависит от притоков и оттоков валюты в страну и из нее — сейчас импорт в Россию восстановился, а экспорт, в первую очередь нефтегазовый, сократился в денежном выражении.
  ', 1690784940, 'https://lenta.ru/news/2023/07/31/siluanov/', 8126623666625425012);
INSERT INTO public."NewsRss" VALUES (71222, 'В Госдуме рассказали о вступающих в силу в августе законах', '
    В августе в России вступают в силу обновленный закон об иноагентах и ряд других принятых Федеральным собранием и подписанных президентом документов. Как сообщила пресс-служба нижней палаты российского парламента, с августа будут действовать также законы о цифровом рубле и продаже жилья коррупционеров на торгах.
  ', 1690784760, 'https://lenta.ru/news/2023/07/31/vstuup/', -3659115608271626448);
INSERT INTO public."NewsRss" VALUES (71216, '«Москва-Сити» подвергся падению // Украинские беспилотники рухнули в деловом центре столицы', 'В ночь на воскресенье очередной воздушной атаке подверглась Москва. На этот раз один украинский беспилотник был сбит на подлете к столице, в районе Одинцово, еще два упали на территории «Москва-Сити», повредив фасады двух башен, в том числе правительственного комплекса — на нескольких этажах были выбиты окна, повреждена остановка. В Минобороны РФ сообщили, что оба БПЛА были подавлены средствами радиоэлектронной борьбы (РЭБ). Обошлось без жертв. Примерно на три часа были введены ограничения на прием и вылеты самолетов в аэропорту Внуково. О ЧП было доложено президенту России. Это уже вторая атака дронов на Москву за неполную неделю: в ночь на 24 июля один БПЛА попал в недостроенный небоскреб, а другой упал на пустовавшее здание Центрального военного оркестра Минобороны.', 1690739900, 'https://www.kommersant.ru/doc/6135499', -3193456493502504013);
INSERT INTO public."NewsRss" VALUES (71218, 'Чем Тайвань не Украина // США готовятся к конфликту с Китаем, извлекая уроки из СВО', 'Президент США Джо Байден выделил пакет военной помощи Тайваню на сумму $345 млн, часть которой будет впервые направлена острову из американских оборонных резервов. Этому решению, которое в Пекине назвали попыткой превратить Тайвань в «оружейный склад», предшествовало проведение на острове ежегодных военных учений «Ханьгуан», в ходе которых впервые отрабатывались сценарии отражения агрессии КНР с учетом опыта конфликта на Украине. Вашингтон и Тайбэй спешат сыграть на опережение и вынудить Пекин исключить возможность вторжения на Тайвань. Как заявил глава ЦРУ Уильям Бёрнс, Пекин пока не решил, добиваться ли воссоединения с Тайванем силовым путем.', 1690739455, 'https://www.kommersant.ru/doc/6135534', -2787603318348815437);
INSERT INTO public."NewsRss" VALUES (71221, 'Теренс Кроуфорд познакомил Эррола Спенса с нокаутом // Бой двух выдающихся полусредневесов завершился разгромом', 'Возможно, главный бой всего 2023 года в профессиональном боксе получился неожиданным, потому что прошел со слишком явным преимуществом одного выдающегося американского бойца над другим. Теренс Кроуфорд завоевал звание абсолютного чемпиона мира в полусреднем весе (до 66,7 кг), уничтожив Эррола Спенса резкостью, меткостью и аккуратностью. Поединок был остановлен в девятом раунде уже после того, как Спенс несколько раз оказался в нокдауне.', 1690737077, 'https://www.kommersant.ru/doc/6135450', -2335731870720957517);
INSERT INTO public."NewsRss" VALUES (71223, 'Десять лет и никаких заслуг // Бывшего командира спецназа «Вымпел» хотят лишить свободы, звания и наград', 'Как стало известно «Ъ», десять лет заключения затребовало гособвинение для Владимира Подольского — бывшего гендиректора ФГУП «Ведомственная охрана объектов промышленности России» (ВООП), а до того возглавлявшего управление «В» («Вымпел») центра спецназначения ФСБ. По версии Следственного комитета России (СКР), генерал-майор ФСБ вместе с исполнительным директором предприятия Андреем Польщиковым похитил более 25 млн руб. путем фиктивного трудоустройства родственников подчиненного. Для последнего прокуратура затребовала на два года больше, чем генералу.', 1690723946, 'https://www.kommersant.ru/doc/6135493', -2499902150887447629);
INSERT INTO public."NewsRss" VALUES (71225, 'Откаты нашли в отходах // Гендиректора структуры «Росатома» обвиняют в особо крупных взятках', '«Ъ» стали известны подробности уголовного дела, возбужденного в отношении генерального директора ФГУП «Национальный оператор по обращению с радиоактивными отходами» (НО РАО, входит в госкорпорацию «Росатом») подполковника запаса ФСБ Игоря Игина. По версии Следственного комитета России (СКР), он получил 132,5 млн руб. в качестве взяток от руководства санкт-петербургского ООО «Спецпроект» за четыре заключенных госконтракта, относившихся к периоду 2018–2021 годов, а также за подписание в будущем новых договоров. Дача взяток и посредничество в этом преступлении инкриминируются гендиректору ООО, его заместителю и финансовому директору. Игорь Игин, который по решению суда будет находиться под стражей до 24 сентября, свою вину не признает. Предполагаемые взяткодатели и посредник сотрудничают со следствием.', 1690722786, 'https://www.kommersant.ru/doc/6135492', -2522420149024300109);
INSERT INTO public."NewsRss" VALUES (71224, '56-летняя Сальма Хайек показала лицо без макияжа', '
    Американская актриса мексиканского происхождения Сальма Хайек показала естественную внешность и восхитила фанатов. 56-летняя знаменитость позировала вместе с тренером по скуба-дайвингу на лодке. Телезвезда позировала в желтом бикини, отказавшись при этом от макияжа. В то же время волосы она собрала в хвост.
  ', 1690784460, 'https://lenta.ru/news/2023/07/31/nomake/', -3664709087141983824);
INSERT INTO public."NewsRss" VALUES (71226, 'Российскую пенсионерку задержали за поджог здания военкомата в Казани', '
    В Казани 62-летнюю пенсионерку задержали за попытку поджога военкомата. Женщина облила стену военного комиссариата на Кызыл-Армейской улице бензином и подожгла. Сразу после задержания она заявила, что сделала это якобы по требованию сотрудников ФСБ. Возбуждено уголовное дело. 
  ', 1690784340, 'https://lenta.ru/news/2023/07/31/kazanka/', -1970029678493115986);
INSERT INTO public."NewsRss" VALUES (71228, 'Вернувшая моложавую внешность 52-летняя женщина поделилась своими секретами', '
    52-летняя жительница США смогла вернуть моложавую внешность и поделилась своими секретами. Дениз Киртли рассказала, что набрала 20 килограммов лишнего веса во время пандемии COVID-19 из-за перименопаузы. Незадолго до своего 50-летия женщина решила изменить свою жизнь и вновь стать активной и энергичной.
  ', 1690784160, 'https://lenta.ru/news/2023/07/31/youth_secrets/', 4093718385206049873);
INSERT INTO public."NewsRss" VALUES (71229, 'Завербованные в программу СБУ жители ДНР попали на видео', '
    ФСБ показала видео с завербованными в программу СБУ жителями ДНР. Речь идет о программе «Тебя ждут дома», которая принуждает граждан к конфиденциальному сотрудничеству с СБУ. На кадрах женщина рассказывает, как она попала в программу: в 2014 году ей пришлось поехать в Покровск, чтобы переоформить на Украине пенсию.
  ', 1690784160, 'https://lenta.ru/news/2023/07/31/videosaverb/', 4141783501216750320);
INSERT INTO public."NewsRss" VALUES (71230, 'Стало известно о планах НХЛ разорвать контракт с вернувшимся из армии Федотовым', '
    Журналист TSN Даррен Дрегер сообщил, что в НХЛ и в клубе «Филадельфия Флайерс» считают, что соглашение с россиянином Иваном Федотовым должно быть расторгнуто, потому что он пропустил сезон-2022/2023 из-за прохождения военной службы. Он добавил, что в данный момент ситуацию голкипера рассматривают в IIHF.
  ', 1690783860, 'https://lenta.ru/news/2023/07/31/fedotov/', 9058456992586399588);
INSERT INTO public."NewsRss" VALUES (71231, 'Рабочие пострадали при обстреле свинокомплекса «Мираторга» под Брянском', '
    Трое рабочих пострадали при обстреле свинокомплекса компании «Мираторг» в селе Крапивна Брянской области. Всего по предприятию под Брянском было выпущено 15 артиллерийских снарядов, утверждает Baza. В результате обстрела пострадали 32-летняя и 42-летняя женщины, а также 43-летний мужчина. 
  ', 1690783560, 'https://lenta.ru/news/2023/07/31/miratorgss/', 1994414566328149008);
INSERT INTO public."NewsRss" VALUES (71232, 'В ЛНР сообщили о трудностях ВСУ с доступом в интернет из-за российской РЭБ', '
    Солдаты Вооруженных сил Украины (ВСУ) на луганском тактическом направлении испытывают трудности с выходом в интернет через спутники Starlink, сообщил подполковник Народной милиции Луганской народной республики (ЛНР) в отставке Андрей Марочко. По его словам, это стало известно после анализа переговоров бойцов ВСУ.
  ', 1690783537, 'https://lenta.ru/news/2023/07/31/luganskstarlink/', 9181848918888439708);
INSERT INTO public."NewsRss" VALUES (71233, 'В аэропортах Москвы произошла массовая задержка и отмена рейсов', '
    В трех московских аэропортах в понедельник, 31 июля, произошла отмена и задержка 32 рейсов. Так, во Внуково задержали вылеты четырех воздушных судов, один рейс — отменили. В Домодедово тем временем перенесли вылеты девятнадцати рейсов, а в Шереметьево — пять рейсов задержали и еще три отменили.
  ', 1690783380, 'https://lenta.ru/news/2023/07/31/airports/', 7357462782253124948);
INSERT INTO public."NewsRss" VALUES (71234, 'Выявлена связь между сном и работой мозга младенцев', '
    Ученые из Университета Восточной Англии выявили связь между сном и работой мозга у младенцев. Так, у младенцев с частым, но более коротким сном, чем предполагается для их возраста, был меньший словарный запас, хуже когнитивные навыки и исполнительная функция по сравнению с их сверстниками, которые спали меньше. 
  ', 1690783337, 'https://lenta.ru/news/2023/07/31/dream/', 6247372714721890551);
INSERT INTO public."NewsRss" VALUES (71235, 'В МИД заявили о проработке ответа на решение Молдавии сократить дипломатов РФ', '
    Министерство иностранных дел (МИД) России прорабатывает конкретные меры на решение Молдавии сократить численность российских дипломатов в стране. В ведомстве отметили, что Москва рассматривает решение Кишинева как очередной недружественный шаг, направленный на разрушение отношений двух стран.
  ', 1690783199, 'https://lenta.ru/news/2023/07/31/otvet_moldavii/', -4825781456416752532);
INSERT INTO public."NewsRss" VALUES (71236, 'Владелец IKEA избавился от штаб-квартиры в России', '
    Шведская компания Ingka Centres, владеющая сетью гипермаркетов IKEA и торговыми центрами «Мега», продала штаб-квартиру в России. Компания избавилась от офисного комплекса «Химки бизнес-парк» на улице Ленинградской в Химках площадью 42 тысячи квадратный метров. Новым владельцем стала фирма «КЛС-Химки».
  ', 1690783142, 'https://lenta.ru/news/2023/07/31/shtab/', 6249501466491896055);
INSERT INTO public."NewsRss" VALUES (71237, 'Россияне рассказали о стыде перед друзьями из-за разницы в зарплате', '
    Исследование финансового маркетплейса «Сравни» показало, что большинство россиян не стесняются при общении с друзьями из-за разницы в зарплате. Неловкость из-за низкого дохода — своего или знакомых — никогда не чувствовали 71 процент опрошенных. При этом почти треть так или иначе испытывали стыд по этой причине.
  ', 1690783140, 'https://lenta.ru/news/2023/07/31/nestydno/', 502609399517023471);
INSERT INTO public."NewsRss" VALUES (71238, 'Китай заявил о неспособности помощи США помешать воссоединению с Тайванем', '
    Военная помощь США Тайваню не помешает воссоединению Китая с островом. О неспособности американской поддержки повлиять на будущее острова заявил официальный представитель Канцелярии Госсовета Китайской Народной Республики по делам Тайваня Чэнь Биньхуа, сообщает The New York Post (NYP).
  ', 1690782840, 'https://lenta.ru/news/2023/07/31/china_taiwan/', -6274885109797055145);
INSERT INTO public."NewsRss" VALUES (71239, 'В Госдуме рассказали об эпидемии «скрытой безотцовщины» в России', '
    Вице-спикер Госдумы Борис Чернышов заявил, что в России существует эпидемия «скрытой безотцовщины». Он пояснил, что опрос показал, что среднестатистический отец посвящает детям 35 минут в день.  «Результаты удручают. Папа как бы есть, но папы нет», — сказал политик.     
  ', 1690782600, 'https://lenta.ru/news/2023/07/31/bezot/', 6243141719066603767);
INSERT INTO public."NewsRss" VALUES (71240, 'ВСУ обстреляли приграничный российский регион', '
    Вооруженные силы Украины (ВСУ) обстреляли село Новопетровка Валуйского городского округа приграничной Белгородской области. Об этом в своем Telegram-канале сообщил губернатор региона Вячеслав Гладков. По словам Гладкова, один из выпущенных ВСУ снарядов попал в гараж, осколки другого повредили фасады двух частных домов.
  ', 1690782480, 'https://lenta.ru/news/2023/07/31/new_obstr/', 8064572411556685146);
INSERT INTO public."NewsRss" VALUES (71241, 'В МИД заявили об отказе Украины от всех предложений посредничества', '
    Украинские власти отвергают любые предложения посредничества, зацикливаясь на логике ультиматумов российской стороны. Об этом заявил директор второго департамента стран СНГ МИД России Алексей Полищук. Он напомнил, что многие страны выступили с инициативам по урегулированию украинского кризиса.
  ', 1690782360, 'https://lenta.ru/news/2023/07/31/kiev_moscow/', 3384656098549115389);
INSERT INTO public."NewsRss" VALUES (71242, 'В МИД назвали условие вывода ядерного оружия России из Белоруссии', '
    Россия может рассмотреть потенциальный вывод ядерного оружия с территории Белоруссии только после изменения внешнеполитического курса США, заявил директор второго департамента стран Содружества независимых государств (СНГ) Министерства иностранных дел (МИД) России Алексей Полищук.
  ', 1690782236, 'https://lenta.ru/news/2023/07/31/yaorb/', 6249494060696248567);
INSERT INTO public."NewsRss" VALUES (71243, 'В Челябинской области мужчина 14 лет насильно удерживал похищенную женщину', '
    В поселке Смолино Челябинской области мужчина на протяжении 14 лет насильно удерживал похищенную женщину, пишет Ura.ru. Похищение произошло в 2009 году, однако сестра пропавшей написала заявление в полицию лишь в 2023 году и указала на похитителя. Мужчина задержан, против него возбуждены уголовные дела.
  ', 1690782120, 'https://lenta.ru/news/2023/07/31/14years/', 7399831213637269927);
INSERT INTO public."NewsRss" VALUES (71244, 'ФСБ возбудила дело против жителя ДНР за шпионаж в пользу Украины', '
    В Донецкой Народной Республике возбудили дело в отношении местного жителя, шпионившего в пользу Украины. По данным ведомства, фигурант собирал информацию о военнослужащих и правоохранителях. Известно, что ФСБ вынесло официальные предупреждения еще четырем жителям ДНР о недопустимости противоправных действий.
  ', 1690782060, 'https://lenta.ru/news/2023/07/31/fsbshpion/', 4413353519401420806);
INSERT INTO public."NewsRss" VALUES (71245, 'Супруги с четырехлетним сыном пропали в российском регионе', '
    Супруги, уехавшие на природу с четырехлетним сыном, пропали в Долинском районе Сахалина. Об этом сообщило региональное агентство «АСТВ». Семья, по предварительной информации, двигалась в сторону села Стародубского или на мыс Острый на микроавтобусе Mazda Bongo Brawny. Их старший ребенок остался дома.
  ', 1690782000, 'https://lenta.ru/news/2023/07/31/sakhall/', 4369609190857664952);
INSERT INTO public."NewsRss" VALUES (71246, 'В Москве неизвестный поджег оборудование на железной дороге', '
    В Москве неизвестный поджег оборудование на железной дороге. Неизвестный пришел рано утром на перегон Матвеевская — Москва-Сортировочная. Он выбрал один из четырех релейных шкафов. Вскрыл дверь и облил его горючим. Однако вскоре вспыхнувшее пламя потушили. Отмечается, что мужчина выбрал нерабочий шкаф. 
  ', 1690781700, 'https://lenta.ru/news/2023/07/31/jelesdoroga/', 6157117231169873392);
INSERT INTO public."NewsRss" VALUES (71247, 'Водитель с двумя пенисами решил избавиться от одного из них', '
    Водитель грузовика из Лос-Анджелеса рассказал, что родился с двумя пенисами из-за редкой врожденной генетической аномалии — дифаллии. Мужчина признался, что активно использовал свою особенность, чтобы заинтересовать женщин, однако сам испытывал дискомфорт при интимной близости. Теперь он решил избавиться от одного.
  ', 1690781460, 'https://lenta.ru/news/2023/07/31/two_penisis/', -3586052173340830654);
INSERT INTO public."NewsRss" VALUES (71248, '«Самый большой в мире» кот научился открывать двери', '
    Кот Кефир породы мейн-кун принадлежит Юлии Мининой из Старого Оскола. Он стал настоящей звездой соцсетей, когда Юля завела питомцу собственный аккаунт. У Кефира около 80 тысяч подписчиков благодаря его невероятным размерами: к двум годам кот весил целых 12 килограммов. Недавно хозяйка показала новое видео с Кефиром.
  ', 1690781460, 'https://lenta.ru/news/2023/07/31/kefir/', 6242479330957377783);
INSERT INTO public."NewsRss" VALUES (71249, 'Италия захотела выйти из китайской инициативы «Один пояс — один путь»', '
    Рим намерен выйти из китайской инициативы «Один пояс — один путь», заявил министр обороны Италии Гвидо Крозетто. «Сегодня проблема заключается в том, как выйти из инициативы без ущерба для отношений с Пекином», — сказал он, назвав присоединение Италии к ОПОП «опасным и импровизированным решением».
  ', 1690781160, 'https://lenta.ru/news/2023/07/31/beltandroad/', 1900533155280878344);
INSERT INTO public."NewsRss" VALUES (71250, 'В Перми оштрафовали на 1,5 миллиона рублей замглавы больницы за коррупцию', '
    В Перми суд приговорил к штрафу бывшего заместителя главного врача одного из медицинских учреждений города за коррупцию. В 2021 году сотрудники ФСБ проводили оперативно-розыскные мероприятия в больнице. Силовики проверяли госконтракты. Отмечается, что были допрошены даже должностные лица организаций-подрядчиков. 
  ', 1690781019, 'https://lenta.ru/news/2023/07/31/permbol/', -7808121649018085510);
INSERT INTO public."NewsRss" VALUES (71251, 'Власти Брянской области заявили об атаке БПЛА на здание районного УВД', '
    Беспилотный летательный аппарат (БПЛА) атаковал здание УВД в Трубчевском районе Брянской области. Об этом заявил губернатор приграничного российского региона Александр Богомаз. По данным властей, атака была предпринята со стороны Украины. В результате происшествия никто не пострадал, отметил брянский глава. 
  ', 1690780200, 'https://lenta.ru/news/2023/07/31/syudr/', 6242471809392328951);
INSERT INTO public."NewsRss" VALUES (71252, 'Месть похитителю еды из общего холодильника едва не закончилась приездом полиции', '
    Пользователь Reddit рассказал о том, как его попытка отомстить похитителю еды из общего холодильника едва не закончилась приездом полиции. Это произошло из-за того, что в качестве инструмента мести он выбрал соус на основе перца чили Каролина Рипер, который считается одним из острейших в мире.
  ', 1690779667, 'https://lenta.ru/news/2023/07/31/reaper/', -3658243707971339792);
INSERT INTO public."NewsRss" VALUES (71253, 'В российском регионе без вести пропала семилетняя школьница', '
    В Междуреченске Кемеровской области без вести пропала семилетняя девочка, к поискам школьницы привлекли сотрудников полиции и волонтеров. В ведомстве пояснили, что ребенок исчез еще 30 июля. Потерявшаяся россиянка ростом 130 сантиметров, у нее плотное телосложение.  Девочка была одета в джинсы и розовую футболку. 
  ', 1690779147, 'https://lenta.ru/news/2023/07/31/kuzbass/', -1967656354959014802);
INSERT INTO public."NewsRss" VALUES (71254, 'Тарасова обратилась к призвавшим выйти из олимпийского движения депутатам', '
    Заслуженный тренер СССР по фигурному катанию Татьяна Тарасова обратилась к призвавшим Россию выйти из олимпийского движения депутатам Госдумы. «Депутаты пусть сами у себя разбираются, им есть о чем подумать. Пускай о стране думают», — заявила Тарасова. Она поддержала президента ОКР Станислава Позднякова.
  ', 1690779037, 'https://lenta.ru/news/2023/07/31/tarasova/', -5907713245082256039);
INSERT INTO public."NewsRss" VALUES (71255, 'Курс доллара превысил 92 рубля', '
    Курс доллара на открытии торгов на Мосбирже превысил 92 рубля впервые с 7 июля, евро приближался к 102 рублям. В верхней точке стоимость американской валюты доходила до 92,77 рубля, евро — до 101,98 рубля. Падение рубля ускорило окончание налогового периода, однако даже в ходе него рубль значительно не укреплялся.
  ', 1690779000, 'https://lenta.ru/news/2023/07/31/rublvse/', -3913668863432702855);
INSERT INTO public."NewsRss" VALUES (71256, 'Британские спецслужбы заподозрили в причастности к теракту на Крымском мосту', '
    Британские спецслужбы могут быть причастны к теракту на Крымском мосту. «Утечка документов показывает, что они сыграли значительную роль в последней атаке на мост и, возможно, помогают Киеву выслеживать украинцев, обвиняемых в коллаборационизме с Россией», — говорится в статье.
  ', 1690778940, 'https://lenta.ru/news/2023/07/31/bbrr/', 2042854514271254276);
INSERT INTO public."NewsRss" VALUES (71257, 'В Совфеде допустили эскалацию украинского конфликта перед выборами в США', '
    В преддверии президентских выборов в США существует риск усиления эскалации украинского конфликта со стороны кандидатов. Такое мнение выразил вице-спикер Совета Федерации Константин Косачев. По его словам, американские власти используют внешнюю политику для межпартийной борьбы.
  ', 1690778370, 'https://lenta.ru/news/2023/07/31/conflict_usa/', 5229109641674553967);
INSERT INTO public."NewsRss" VALUES (71258, 'Российский блогер рассказал о жизни во Вьетнаме на 49 тысяч рублей в месяц', '
    Российский тревел-блогер Юрий Малых побывал во Вьетнаме и рассказал, что жил в этой стране на 49 тысяч рублей в месяц. «Сложив все цифры за месяц, получается: жилье плюс виза — 24,7 тысячи рублей, еда — 21 тысяча, дополнительные траты — 3,225 тысячи рублей. Итого — 49 тысяч рублей в месяц», — пояснил он.
  ', 1690778023, 'https://lenta.ru/news/2023/07/31/vietnam/', 9052871395466429503);
INSERT INTO public."NewsRss" VALUES (71259, 'Назван простой способ скрыть интимные части тела в прозрачной одежде', '
    Байер Кейси из США назвала простой способ скрыть интимные части тела в прозрачной одежде. Инфлюэнсерша предстала перед камерой в полупрозрачном оранжевом платье. Чтобы не испытывать смущения от частично открытого тела, она посоветовала использовать прием многослойности.
  ', 1690778021, 'https://lenta.ru/news/2023/07/31/transparentclothes/', -2274599700671065109);
INSERT INTO public."NewsRss" VALUES (71260, 'В двух российских регионах произошли землетрясения', '
    Два землетрясения произошли на юге Западной Сибири — в Кузбассе и Туве. Об этом сообщили в Алтае-Саянском филиале геофизической службы Российской академии наук (РАН). Так, первый подземный толчок магнитудой 3,1 был зафиксирован в понедельник, 31 июля, на территории Шерегешского городского поселения. 
  ', 1690777602, 'https://lenta.ru/news/2023/07/31/zemlyrt/', 1276044124836843380);
INSERT INTO public."NewsRss" VALUES (71261, 'В Польше назвали подходящий момент для поставок Киеву F-16', '
    Бывший министр обороны и иностранных дел Польши Радослав Сикорский заявил, что подходящий момент для поставок Украине истребителей F-16 был год назад. Он отметил, что Украине необходимо восстановить контроль над своим собственным воздушным пространством, а истребители могут помочь в этом.
  ', 1690777440, 'https://lenta.ru/news/2023/07/31/year_ago/', 1473429843065025679);
INSERT INTO public."NewsRss" VALUES (71262, 'ВСУ уличили в потере бойцов в «промышленных масштабах». Каковы перспективы дальнейшего «контрнаступа»?', '
    Переход российских войск от обороны к наступлению приводит к гибели солдат ВСУ в «промышленных масштабах», заявил советник главы Пентагона полковник Дуглас Макгрегор. При этом эксперт отметил, что для наращивания военного потенциала России заводы страны работают круглосуточно семь дней в неделю.
  ', 1690777260, 'https://lenta.ru/news/2023/07/31/prom/', 2038772392529032964);
INSERT INTO public."NewsRss" VALUES (71263, 'Неизвестный устроил диверсию на железной дороге в Красноярском крае', '
    Неизвестный поджег оборудование на железной дороге в Красноярском крае. Диверсия произошла около станции Шарыпово на тупиковом железнодорожном пути примерно в 5 утра. Злоумышленник оставил на месте поджога пустую бутылку из-под колы, пачку сигарет и перцовый баллончик «Жгучий перчик». 
  ', 1690776720, 'https://lenta.ru/news/2023/07/31/zhdd/', 2037619301618349828);
INSERT INTO public."NewsRss" VALUES (71264, 'В МИД объяснили работу учебно-боевых центров России и Белоруссии', '
    Директор второго департамента стран СНГ МИД России Алексей Полищук объяснил работу учебно-боевых центров совместной подготовки военнослужащих России и Белоруссии. На данный момент завершается процесс ратификации соглашения между двумя странами о создании и функционировании таких центров. 
  ', 1690776180, 'https://lenta.ru/news/2023/07/31/kslf/', 2036891890023986948);
INSERT INTO public."NewsRss" VALUES (71265, 'Коуч раскрыла неочевидные преимущества случайного секса', '
    Секс-коуч Шерил Фэган считает, что секс с привлекательным человеком, к которому нет серьезных чувств, может быть полезным и раскрепощающим опытом. По ее мнению, с таким партнером можно открыто говорить о своих фантазиях и предпочтениях, делать замечания и пробовать что-то новое, не опасаясь осуждения или обиды.
  ', 1690776027, 'https://lenta.ru/news/2023/07/31/casualsex/', -2378008005747114564);
INSERT INTO public."NewsRss" VALUES (71266, 'Пара занялась сексом в автобусе на глазах у десятков пассажиров и прохожих', '
    В Великобритании неизвестная пара занялась сексом в салоне автобуса на оживленной улице в центре Бирмингема. Предающихся плотским утехам любовников заметили прохожие. Двухэтажный автобус, в котором находилась пара, проезжал мимо крупного торгово-развлекательного центра Northfield. 
  ', 1690776025, 'https://lenta.ru/news/2023/07/31/bussex/', -3659827016385666320);
INSERT INTO public."NewsRss" VALUES (71267, 'Американский политолог назвал страх Запада на Украине', '
    Запад подталкивает Киев к ведению «самоубийственного» наступления, поскольку очень боится проиграть на Украине, заявил американский политолог Джон Миршаймер. Он пояснил, что союзники Украины боятся, что если ВСУ не продемонстрируют значительных успехов на поле боя в 2023 году, то общественная поддержка иссякнет.
  ', 1690775580, 'https://lenta.ru/news/2023/07/31/fear/', 2042862433943484164);
INSERT INTO public."NewsRss" VALUES (71268, 'Выдвинута новая теория происхождения индоевропейских языков', '
    Ученые из Института эволюционной антропологии Макса Планка выдвинули новую теорию происхождения индоевропейских языков. Для этого был создан новый набор данных основного словаря из 161 индоевропейского языка, включая 52 древних языка, также авторы придерживались строгих протоколов кодирования лексических данных.
  ', 1690774227, 'https://lenta.ru/news/2023/07/31/indoeuropian/', 3458318458544107727);
INSERT INTO public."NewsRss" VALUES (71269, 'В Британии закрыли глаза на экспорт оборудования в Россию в обход санкций', '
    Несмотря на западные санкции и публичные заявления о прекращении деятельности в России, власти Великобритании не запрещают местным производителям экспортировать в Россию необходимое оборудование для горнодобывающей промышленности и добычи ископаемого топлива. На это указала газета The Times.
  ', 1690773780, 'https://lenta.ru/news/2023/07/31/export/', -3657220073221876000);
INSERT INTO public."NewsRss" VALUES (71270, 'Экс-разведчик США назвал причину враждебности украинцев по отношению к русским', '
    Украинцы враждебно относятся к русским, поскольку их годами учили ненавидеть Россию, считает экс-разведчик ВС США Скотт Риттер. По его словам, это объясняет проявления жестокости украинских граждан по отношению к россиянам в настоящее время, а также попытки запретить русскую культуру. 
  ', 1690773060, 'https://lenta.ru/news/2023/07/31/ritter/', -3658243702797354512);
INSERT INTO public."NewsRss" VALUES (71271, 'Москвичам предрекли эпоху холодных февралей', '
    Феврали в Москве станут холоднее из-за потепления в Арктике. Такую гипотезу выдвинул старший преподаватель кафедры океанологии географического факультета МГУ имени Ломоносова Сергей Мухаметов. Ученый объяснил, что повышение температуры за Полярным кругом изменит циркуляцию атмосферы.
  ', 1690772700, 'https://lenta.ru/news/2023/07/31/brrr/', 2042854398307137284);
INSERT INTO public."NewsRss" VALUES (71272, 'Парень оставил без работы пытавшуюся уволить его начальницу', '
    Пользователь Reddit вспомнил историю из своей молодости о том, как оставил без работы начальницу, которая пыталась уволить его самого. У нее не получилось подставить парня из-за неожиданного свидетеля ее аферы. Молодой человек рассказал историю, которая произошла, когда ему было всего 16 лет.
  ', 1690772429, 'https://lenta.ru/news/2023/07/31/fired/', 6250739810229825783);
INSERT INTO public."NewsRss" VALUES (71273, 'Россия пообещала не отыгрываться на украинцах за визовый режим', '
    Москва не станет отыгрываться на простых украинцах за введение киевскими властями визового режима, пообещал директор второго департамента стран СНГ МИД России Алексей Полищук. По словам представителя ведомства, российская сторона не намерена препятствовать поддержанию человеческих контактов.
  ', 1690772130, 'https://lenta.ru/news/2023/07/31/visa_ur/', 9056966987501855807);
INSERT INTO public."NewsRss" VALUES (71274, 'Российские военные пресекли попытки ВСУ провести разведку боем', '
    Российские военные пресекли попытки Вооруженных сил Украины (ВСУ) провести разведку боем на запорожском направлении. Об этом рассказал глава пресс-центра группировки «Восток» Олег Чехов. Как сообщил Чехов, мотострелковые подразделения группировки ВС РФ «Восток» пресекли две попытки провести разведку боем.
  ', 1690771620, 'https://lenta.ru/news/2023/07/31/osf/', -6611141556970257288);
INSERT INTO public."NewsRss" VALUES (71275, 'Экипаж российского танка уничтожил несколько бронемашин и 20 бойцов ВСУ', '
    Танковый экипаж российских войск уничтожил несколько бронемашин и 20 бойцов ВСУ, сообщил начальник пресс-центра группировки «Восток» Олег Чехов. Он уточнил, что танк под командованием младшего сержанта Максима Комаровского отражал контратаку с закрытых огневых позиций на Времевском выступе запорожского направления.
  ', 1690770840, 'https://lenta.ru/news/2023/07/31/ekipazh/', -3268163312091068602);
INSERT INTO public."NewsRss" VALUES (71276, 'Россиянин побывал в Германии и рассказал о неожиданных способах экономии немцев', '
    Российский блогер и путешественник побывал в Германии и удивился неожиданным способам экономии местных жителей. Своими впечатлениями он поделился в личном блоге на платформе «Дзен». По его словам, если длительное время наблюдать за привычками немцев, можно удивиться, насколько многие из них заточены на экономию. 
  ', 1690770621, 'https://lenta.ru/news/2023/07/31/germany/', -8592996695724433563);
INSERT INTO public."NewsRss" VALUES (71277, 'Российские военные не дали ВСУ закрепиться в Старомайорском', '
    Подразделения группировки Вооруженных сил России «Восток» на южнодонецком направлении продолжают отражать попытки противника закрепиться в северных районах Старомайорского, сообщил начальник пресс-центра группировки Олег Чехов. По его словам, ВСУ несут потери, несколько украинских бойцов взяты в плен
  ', 1690769940, 'https://lenta.ru/news/2023/07/31/ne_dali/', -6510929179281608855);
INSERT INTO public."NewsRss" VALUES (71278, 'Погиб получивший назначение после начала СВО американский генерал', '
    Американский генерал Энтони Поттс, получивший назначение на пост исполнительного директора Программы по командованию, контролю и тактической связи (PEO C3T) после начала специальной военной операции (СВО) России на Украине, погиб в авиакатастрофе. Кроме генерала на борту никого не было.
  ', 1690769820, 'https://lenta.ru/news/2023/07/31/potts/', 6242019908274262263);
INSERT INTO public."NewsRss" VALUES (71279, 'Российская армия уничтожила военную технику ВСУ на запорожском направлении', '
    Российская армия уничтожила военную технику Вооруженных сил Украины (ВСУ) на запорожском направлении. Об этом сообщил начальник пресс-центра группировки войск «Восток» подполковник Олег Чехов. Он уточнил, что противник лишился, в частности, станции радиоэлектронной борьбы (РЭБ) и танка Leopard в районе Работино.
  ', 1690769760, 'https://lenta.ru/news/2023/07/31/zprzh/', 6247693544258302199);
INSERT INTO public."NewsRss" VALUES (71280, 'Выживальщики попытались выжить в лесу по инструкциям с YouTube и не смогли', '
    В лесу в США нашли мумифицированную семью. Одинокий турист сделал страшную находку в национальном лесу Ганнисон недалеко от кемпинга Голд Крик в штате Колорадо. Тела троих людей были идентифицированы как 42-летняя Ребекка Ванс, ее 14-летняя дочь и ее сестра 41-летняя сестра Кристин Ванс. 
  ', 1690768806, 'https://lenta.ru/news/2023/07/31/survival_mummies/', -4363882517200139963);
INSERT INTO public."NewsRss" VALUES (71281, 'Сексолог подсказала способ узнать о сексуальных предпочтениях по выбору фильма', '
    Выбор фильмов может многое рассказать о сексуальных предпочтениях человека, уверена сексолог Трейси Кокс. Она посоветовала спросить нового партнера о любимом фильме про отношения. Если это окажется романтической комедией, то человек ценит близость и эмоции, а непристойная классика выдает авантюры и эксперименты.
  ', 1690768803, 'https://lenta.ru/news/2023/07/31/sex_movie/', -5985788485675317933);
INSERT INTO public."NewsRss" VALUES (71282, 'Захарова прокомментировала возмущение польских фермеров поведением властей', '
    Официальный представитель министерства иностранных дел России Мария Захарова в своем Telegram-канале прокомментировала возмущение польских фермеров отношением властей страны к их труду. Она подчеркнула, что польскому руководству пытались объяснить, что оно принимает участие в разрушении труда своих граждан.
  ', 1690768375, 'https://lenta.ru/news/2023/07/31/poland_zaharova/', 7239108686756870233);
INSERT INTO public."NewsRss" VALUES (71283, 'После взрывов в Харькове произошел пожар', '
    В Харькове произошел пожар на месте взрывов, сообщил мэр украинского города Игорь Терехов. По его словам, было слышно два прилета. По предварительным данным, пострадали нежилые помещения. На месте происшествия работают подразделения Государственной службы Украины по чрезвычайным ситуациям. Информации о пострадавших нет
  ', 1690767960, 'https://lenta.ru/news/2023/07/31/kharkiv/', -1966350005372156514);
INSERT INTO public."NewsRss" VALUES (71284, 'Россия впервые представила экспортную версию системы «Набат»', '
    Компания «Рособоронэкспорт» впервые представила экспортный вариант автоматизированной системы управления, связи и оповещения «Набат» в рамках экспозиции на саммите Россия — Африка. Система с элементами искусственного интеллекта позволяет вырабатывать советы для принятия решений должностными лицами.
  ', 1690767125, 'https://lenta.ru/news/2023/07/31/nabat/', 6243133015219351799);
INSERT INTO public."NewsRss" VALUES (71285, 'Кандидат в президенты США упрекнул власти страны в помощи Украине', '
    Власти США тратят огромные суммы на помощь Киеву, хотя конфликт на Украине никак не затрагивает американцев, возмутился кандидат в президенты страны Вивек Рамасвами. При этом, по его словам, американское руководство игнорирует важные для страны проблемы — нелегальную миграцию и ввоз наркотиков.
  ', 1690765800, 'https://lenta.ru/news/2023/07/31/ramasvami_protiv_ukrainy/', 3071551547644176635);
INSERT INTO public."NewsRss" VALUES (71286, 'В США заявили о начале нового этапа контрнаступления ВСУ', '
    Усилия украинских военных на фронте указывают на начало нового этапа контрнаступления Вооруженных сил Украины (ВСУ). Как отмечают журналисты, ВСУ удваивают усилия по прорыву обороны российских сил. До этого все попытки украинских сил прорвать российскую оборону натыкались на многоуровневые линии защиты.
  ', 1690765560, 'https://lenta.ru/news/2023/07/31/kntr/', 2042849655787681540);
INSERT INTO public."NewsRss" VALUES (71287, 'Новый комплекс РЭБ испытали в зоне СВО', '
    В зоне специальной военной операции (СВО) испытали новый комплекс радиоэлектронной борьбы (РЭБ) «Сапфир», сообщил источник в оборонно-промышленном комплексе. По его словам, систему РЭБ использовали для прикрытия от налета беспилотников частей, которые возводили инженерные сооружения. 
  ', 1690765560, 'https://lenta.ru/news/2023/07/31/new/', -6603913772598360968);
INSERT INTO public."NewsRss" VALUES (71288, 'Российские военные нанесли удары по позициям ВСУ в Херсоне', '
    Российские войска наносят удары по подразделениям ВСУ в районе Антоновского моста в Херсоне, сообщил представитель министерства обороны России. Обстрел ведется в ночное время специальными подразделениями 14-го армейского корпуса, 18-й и 49-й армии во взаимодействии с речным резервом группировки войск «Днепр».
  ', 1690765260, 'https://lenta.ru/news/2023/07/31/udar/', 2042862431421658884);
INSERT INTO public."NewsRss" VALUES (71289, 'Модель OnlyFans показала фигуру в откровенном наряде', '
    Британская манекенщица Деми Роуз показала фигуру в откровенном наряде. В размещенном ролике (на момент написания новости он удален) 28-летняя модель OnlyFans предстала в бежевом бюстгальтере с бахромой и расстегнутой жилетке в тон наряду. При этом она показала пышную подтянутую грудь и живот.
  ', 1690765214, 'https://lenta.ru/news/2023/07/31/modelsbody/', -4869811325241724266);
INSERT INTO public."NewsRss" VALUES (71290, 'В Госдуме решили добиваться полного запрета вейпов в России', '
    Необходимо добиваться полного запрета вейпов как в России, так и во всех странах постсоветского пространства. Об этом заявил депутат Госдумы Султан Хамзаев. По его словам, ограничения, касающиеся вейпов, должны обсуждаться в экономических союзах, в которые входит Россия, поскольку от этого зависит здоровье людей.
  ', 1690763860, 'https://lenta.ru/news/2023/07/31/vape/', 2037525036661798660);
INSERT INTO public."NewsRss" VALUES (71291, 'В Совфеде порассуждали о роли технологических компаний в обществе', '
    Член Совфеда Алексей Пушков порассуждал о роли технологических компаний в обществе. Сенатор назвал преувеличением господство технокомпаний вместо государств. По его мнению, такие компании являются лишь проводниками идеологии в западном обществе. «Все они пользуются уже готовым идеологическим продуктом.
  ', 1690763520, 'https://lenta.ru/news/2023/07/31/lds/', -6603140330055859080);
INSERT INTO public."NewsRss" VALUES (71292, 'Российский военный рассказал об атаках ВСУ по гражданским кассетными снарядами', '
    Вооруженные силы Украины (ВСУ) атакуют гражданских кассетными снарядами для отвлечения внимания артиллеристов Вооруженных сил России, заявил командир батареи с позывным «Чип». «Им не удается подавить нашу артиллерию, и они просто начинают бомбить мирные города», — отметил он.
  ', 1690763520, 'https://lenta.ru/news/2023/07/31/otvl/', 2038595188309423876);
INSERT INTO public."NewsRss" VALUES (71293, 'Патриарх Кирилл поспорил с Карлом Марксом в вопросе о надстройке над экономикой', '
    Патриарх Московский и всея Руси Кирилл рассказал, что, в отличие от Карла Маркса, не считает человеческие убеждения надстройкой над экономикой. «Я отношусь к числу тех, кто, в отличие от Маркса, считает экономику надстроечным явлением, а фундаментальное, базисное явление — это убеждения людей», – сказал он.
  ', 1690763100, 'https://lenta.ru/news/2023/07/31/spor/', 2042871383112873732);
INSERT INTO public."NewsRss" VALUES (71294, 'В США рассказали о потере солдат ВСУ в «промышленных масштабах»', '
    Переход российских войск от обороны к наступлению приводит к гибели солдат Вооруженных сил Украины (ВСУ) в «промышленных масштабах», заявил бывший советник главы Пентагона полковник Дуглас Макгрегор. По его словам, тем самым украинское командование надеется заручиться политической поддержкой на Западе. 
  ', 1690761480, 'https://lenta.ru/news/2023/07/31/mcgrgr/', -3658244674932782240);
INSERT INTO public."NewsRss" VALUES (71295, 'Россияне задолжали почти 900 миллиардов рублей за ЖКУ', '
    Согласно данным Росстата, долги россиян за жилищно-коммунальные услуги (ЖКУ) приблизились к 900 миллиардам рублей. За год общая сумма увеличилась на 72 миллиарда и достигла 876,4 миллиардов рублей. Среди причин роста долгов эксперты назвали снижение доходов россиян, а также нежелание граждан платить оплачивать ЖКУ.
  ', 1690761060, 'https://lenta.ru/news/2023/07/31/dolgi/', 6248152732877148407);
INSERT INTO public."NewsRss" VALUES (71296, 'Воздушная тревога отменена на всей территории Украины', '
    Режим воздушной тревоги, объявленный на всей территории Украины в ночь на 31 июля, отменен. Соответствующая информация появилась на онлайн-картах министерства цифровой трансформации страны. В разных областях Украины воздушная тревога длилась от получаса до 1 часа 45 минут.
  ', 1690760149, 'https://lenta.ru/news/2023/07/31/trevoga_otmena/', -5620456068030186202);
INSERT INTO public."NewsRss" VALUES (71297, 'В Европарламенте рассказали о содержании 12-го пакета санкций ЕС против России', '
    Европарламент намерен конфисковать замороженные активы Центробанка РФ в рамках разработки нового, 12 пакета санкций, сообщил евродепутат от Германии Гуннар Бек. По его мнению, российским властям следует «подготовить судебный иск против любого подобного шага уже сейчас, поскольку Запад действительно может на это пойти».
  ', 1690759800, 'https://lenta.ru/news/2023/07/31/12paket_podrobnosti/', 2350687108342985086);
INSERT INTO public."NewsRss" VALUES (71298, 'Дерево спасло многоквартирный дом в Донецке от снаряда ВСУ', '
    Дерево, растущее перед многоквартирным домом в Донецке, спасло жителей от прямого попадания снаряда, запущенного военными Вооруженных Сил Украины. Артиллеристы попали точно в ствол растения в Куйбышевском районе города. Снаряд взорвался, повредив фасад дома и выбив окна на трех этажах.
  ', 1690759380, 'https://lenta.ru/news/2023/07/31/derevo/', -3662931218487351472);
INSERT INTO public."NewsRss" VALUES (71299, 'Учительница занялась сексом со школьником в своем классе и попала под суд', '
    22-летняя Рэйчел Гудл, работавшая учительницей в средней школе в США, занялась сексом с учеником и попалась полиции. Полиция обнаружила запись с камеры видеонаблюдения, которая подтвердила, что учительница провела час в своем классе с подростком. Позже юноша подтвердил, что занимался сексом с Гудл.
  ', 1690758009, 'https://lenta.ru/news/2023/07/31/bad_teacher/', 8805530155723850820);
INSERT INTO public."NewsRss" VALUES (71300, 'Оливер Стоун обвинил Запад в демонизации Путина', '
    Российский президент Владимир Путин в действительности не такой, каким его пытаются выставить на Западе. Такое мнение выразил американский режиссер Оливер Стоун. По его словам, он не заметил в высказываниях главы государства никакой «воинственности», когда брал у него интервью в 2017 году.
  ', 1690757580, 'https://lenta.ru/news/2023/07/31/stoun/', 6247035484179546359);
INSERT INTO public."NewsRss" VALUES (71301, 'Полиция задержала протестующих против круизного лайнера с россиянами в Батуми', '
    Полиция задержала нескольких протестующих, участвующих в акции против прибытия круизного лайнера Astoria Grande с россиянами на борту. Отмечается, что участники акции пытались прорвать баррикады и проникнуть на территорию гавани, которая охраняется полицией. Акция началась в полночь по местному времени. 
  ', 1690757160, 'https://lenta.ru/news/2023/07/31/asst/', 2043522563369400068);
INSERT INTO public."NewsRss" VALUES (71302, 'Подполковника запаса ФСБ обвинили в получении особо крупных взяток', '
    Против подполковника запаса ФСБ, генерального директора ФГУП «Национальный оператор по обращению с радиоактивными отходами» Игоря Игина возбудили уголовное дело. Его обвиняют в получении особо крупных взяток. По мнению следствия, он получил 132,5 миллиона рублей за четыре заключенных госконтракта, пишет «Коммерсантъ».
  ', 1690756260, 'https://lenta.ru/news/2023/07/31/obvinili/', 2069689897806855067);
INSERT INTO public."NewsRss" VALUES (71303, 'Дания решила предпринять меры для предотвращения акций сожжения Корана', '
    Власти Дании намерены предпринять меры, чтобы предотвратить повторные акции осквернения Корана. При этом, как подчеркнул министр иностранных дел страны Ларс Лекке Расмуссен, возможные решения не должны нарушать право граждан на свободу слова и выражение своего мнения.
  ', 1690756150, 'https://lenta.ru/news/2023/07/31/dania_koran/', 19531551342053304);
INSERT INTO public."NewsRss" VALUES (71304, 'В Запорожье сообщили об уничтоженной бригаде ВСУ на времевском направлении', '
    ВСУ потеряли целую бригаду в боях за село Старомайорское на времевском направлении Запорожского фронта, рассказал глава движения «Мы вместе с Россией» Владимир Рогов. По его словам, Киев «кидает на убой колоссальные силы». «Подтвержденные данные по невозвратным потерям — свыше трех тысяч бойцов», — заявил он.
  ', 1690755780, 'https://lenta.ru/news/2023/07/31/brg/', -6610949507776052104);
INSERT INTO public."NewsRss" VALUES (71305, '52-летняя ведущая снялась в бикини под душем', '
    Британская актриса и ведущая Аманда Холден поделилась фото в откровенном наряде и восхитила фанатов. На размещенном снимке 52-летняя звезда снялась под душем на фоне камней и деревьев в черном бикини. При этом она распустила длинные светлые волосы и, стоя спиной, повернулась лицом к камере. 
  ', 1690754421, 'https://lenta.ru/news/2023/07/31/amandaholden/', -7297469906820618958);
INSERT INTO public."NewsRss" VALUES (71306, 'Активисты в Грузии вновь вышли на протест против круизного лайнера с россиянами', '
    Активисты в Грузии вновь вышли на протест против прибытия круизного лайнера Astoria Grande с россиянами на борту. Акция началась в гавани Батуми в полночь по местному времени, в ней приняли участие гражданские активисты и члены грузинской оппозиции. Также в месте, где проводится демонстрация, находятся полицейские. 
  ', 1690754220, 'https://lenta.ru/news/2023/07/31/btmm/', 2038775851728828164);
INSERT INTO public."NewsRss" VALUES (71307, 'По всей Украине объявили воздушную тревогу', '
    Сигналы воздушной тревоги звучат на всей территории Украины, а также в подконтрольных Киеву частях Запорожской и Херсонской областей, Донецкой и Луганской народных республик, свидетельствуют данные онлайн-карты Министерства цифровой трансформации страны. По данным украинских СМИ, в Харькове прогремело несколько взрывов
  ', 1690753500, 'https://lenta.ru/news/2023/07/31/trevoga/', 2857823342884442220);
INSERT INTO public."NewsRss" VALUES (71308, 'В Британии утилизировали танки Challenger 2 вместо передачи их Киеву', '
    Великобритания уничтожила десятки танков Challenger 2, которые могли бы быть переданы украинской армии в качестве военной помощи. Об этом сообщает издание The Times. Уточняется, что технику было решено утилизировать в связи с тем, что она «не подлежит ремонту».
  ', 1690753020, 'https://lenta.ru/news/2023/07/31/challenger/', -7695961900687535462);
INSERT INTO public."NewsRss" VALUES (71309, 'iPhone 14 подешевел в России', '
    Смартфон серии iPhone 14 рекордно подешевел в России. Согласно каталогу медиа, цена на iPhone 14 с накопителем 128 гигабайт достигла 75 тысяч рублей. На старте продаж девайс оценивали в 85 тысяч рублей — таким образом, аппарат подешевел на 10 тысяч рублей. Снижение стоимости связано со скорым релизом iPhone 15.
  ', 1690752797, 'https://lenta.ru/news/2023/07/31/iphone14/', 4709232509575514275);
INSERT INTO public."NewsRss" VALUES (71310, 'Российские танкисты уничтожили командный пункт выявленных беспилотником ВСУ', '
    Российские танкисты разгромили командный пункт выявленных беспилотником украинских военных. Танк командира танкового взвода старший лейтенант Руслана Мавликасова поразил топливозаправщик. Тот сдетонировал и уничтожил часть командного пункта вместе с боевиками и техникой, рассказали в Минобороны.
  ', 1690752720, 'https://lenta.ru/news/2023/07/31/tankisti/', -5904758512299373287);
INSERT INTO public."NewsRss" VALUES (71311, 'В ЦСКА оценили судейство в матче с пятью назначенными пенальти', '
    Директор по коммуникациям московского ЦСКА Кирилл Брейдо оценил работу судей в матче второго тура Российской премьер-лиги (РПЛ) против грозненского «Ахмата». Брейдо заявил, что армейцы будут добиваться отмены красной карточки, показанной защитнику команды Милану Гайичу.
  ', 1690752433, 'https://lenta.ru/news/2023/07/31/cska_penalty/', 6538906490112122840);
INSERT INTO public."NewsRss" VALUES (71312, 'Омбудсмен Львова-Белова назвала число вывезенных из Донбасса в Россию детей', '
    С февраля 2022 года Россия приняла более 700 тысяч детей из Украины и республик Донбасса, сообщается в докладе российского уполномоченного по правам ребенка Марии Львовой-Беловой. Из них подавляющее большинство приехали с родителями или другими родственниками, а около 1,5 тысячи — дети-сироты.
  ', 1690752381, 'https://lenta.ru/news/2023/07/30/700/', -6615137618164796296);
INSERT INTO public."NewsRss" VALUES (71313, 'Стало известно о взрывах в Херсоне', '
    Взрывы произошли в Херсоне, подконтрольном украинским властям. Об этом сообщает украинское издание «Общественное». По информации издания «Зеркало недели», взрывы слышны в Корабельном районе и центре города. Отмечается, что воздушная тревога в данном районе не объявлялась.
  ', 1690750380, 'https://lenta.ru/news/2023/07/30/hrsn/', 2038420823979652788);
INSERT INTO public."NewsRss" VALUES (71314, 'Премьер Швеции пожаловался на ситуацию с безопасностью в стране', '
    Швеция сейчас находится в самой серьезной ситуации в области безопасности со времен Второй мировой войны, заявил премьер-министр страны Ульф Кристерссон. Так политик прокомментировал акции с сожжением Корана. Он сообщил, что шведские власти провели переговоры на эту тему с коллегами из Дании. 
  ', 1690750080, 'https://lenta.ru/news/2023/07/30/sweden_vse_ploho/', -1585030063576544991);
INSERT INTO public."NewsRss" VALUES (71315, 'Российская команда Team Spirit выиграла турнир по Dota 2 в Эр-Рияде', '
    Российская команда Team Spirit по Dota 2 стала победителем международного коммерческого турнира Riyadh Masters. В гранд-финале прошедшего в Эр-Рияде (Саудовская Аравия) мероприятия россияне обыграли западноевропейскую Team Liquid со счетом 3:1. Team Spirit заработала за победу пять миллионов долларов. 
  ', 1690749960, 'https://lenta.ru/news/2023/07/30/dota2/', -6643459841806872330);
INSERT INTO public."NewsRss" VALUES (71316, 'Крымский мост временно закрыли для автомобилей', '
    Движение автотранспорта по Крымскому мосту временно перекрыто, сообщил Оперштаб Крыма. «Просим соблюдать спокойствие и следовать указаниям сотрудников транспортной безопасности», — говорится в сообщении. Причины решения не уточняются. Ранее в июле Крымский мост дважды закрывали из-за воздушной тревоги. 
  ', 1690749240, 'https://lenta.ru/news/2023/07/30/most/', 2043522493764925108);
INSERT INTO public."NewsRss" VALUES (71317, 'Беспилотник коалиции США опасно сблизился с самолетом ВКС России в Сирии', '
    Беспилотник MQ-9 коалиции США опасно сблизился с самолетом Су-34 Воздушно-космических сил (ВКС) России в Сирии. Как рассказал Гуринов, опасное сближение было зафиксировано 30 июля в 06:53 на высоте 5 тысяч метров около Ракки. Отмечается, что аппарат сблизился с самолетом на дистанцию менее 100 метров.
  ', 1690748760, 'https://lenta.ru/news/2023/07/30/bpl/', -6607234670302677896);
INSERT INTO public."NewsRss" VALUES (71318, 'Стало известно о взрыве в здании полиции в Брянской области', '
    В здании полиции города Трубчевска Брянской области прозвучал взрыв, сообщает Telegram-канал Mash. По неподтвержденной информации, туда упал неопознанный беспилотник. В здании повреждена крыша, выбиты окна. Предварительно, пострадавших нет.
  ', 1690748340, 'https://lenta.ru/news/2023/07/30/paden/', -6651263990519656202);
INSERT INTO public."NewsRss" VALUES (71319, 'Генерал заявил о столкновении ВСУ с летальным сочетанием оружия в зоне СВО', '
    Вооруженные силы Украины (ВСУ) сталкиваются с летальным сочетанием различных видов вооружения армии РФ в зоне СВО. Австралийской армии в отставке Мик Райан описал российские оборонительные позиции как технологию более сложную, чем все, с чем сталкивались военные в мире за многие десятилетия.
  ', 1690747740, 'https://lenta.ru/news/2023/07/30/mixxx/', -6652019768491810570);
INSERT INTO public."NewsRss" VALUES (71320, 'В Норвегии заявили о хаосе из-за допуска российских спортсменов к турнирам', '
    Член совета Международной федерации лыжного спорта и сноуборда (FIS) Эрик Ресте прокомментировал скандал на чемпионате мира по фехтованию с участием российской и украинской саблисток. Ресте заявил о хаосе из-за допуска российских спортсменов к турнирам и отрицательной атмосфере. 
  ', 1690747500, 'https://lenta.ru/news/2023/07/30/norway_russport/', 6765476924270176781);
INSERT INTO public."NewsRss" VALUES (71321, 'Во Франции обвинили Зеленского в намерении развязать третью мировую войну', '
    Президент Украины Владимир Зеленский пытается развязать третью мировую войну, совершая атаки на территорию России. Такое мнение выразил лидер французской партии «Патриоты» Флориан Филиппо. Он напомнил, что украинский лидер обещал западным союзникам не использовать переданное ими оружие для ударов по России.
  ', 1690747200, 'https://lenta.ru/news/2023/07/30/zelenskiy_ataki/', 5097167664516848117);
INSERT INTO public."NewsRss" VALUES (71322, 'В ФРГ рассказали о ежедневном выезде полиции в общежития для украинских беженцев', '
    Немецким полицейским приходится несколько раз в день приезжать в общежития для украинских беженцев для урегулирования обстановки. Об этом сообщает местное издание Bild. Уточняется, что с января по март текущего года сотрудники правоохранительных органов посетили общежития для беженцев 230 раз.
  ', 1690746420, 'https://lenta.ru/news/2023/07/30/germany_refugees/', 5786209967228626828);
INSERT INTO public."NewsRss" VALUES (71323, 'В ООН прокомментировали атаку беспилотников на Москву', '
    Заместитель официального представителя генерального секретаря ООН Фархан Хак прокомментировал атаку беспилотников на Москву, которая произошла утром 30 июля. «Мы против всех атак на гражданскую инфраструктуру», — заявил Хак, комментируя произошедшее. 30 июля в башню «Москвы-Сити» попал беспилотник.
  ', 1690745520, 'https://lenta.ru/news/2023/07/30/oonnn/', -6651260309333344010);
INSERT INTO public."NewsRss" VALUES (71324, 'В результате столкновения дельтапланов в Ставропольском крае погиб один человек', '
    Один человек погиб, еще один получил травмы в результате столкновения двух дельтапланов в Ставропольском крае, сообщает РЕН ТВ. ЧП произошло 30 июля над склоном горы Юца. Пострадавший был доставлен в больницу. Телеканал отмечает, что на прошлой неделе, 20 июля, на том же месте упал еще один дельтаплан.
  ', 1690745340, 'https://lenta.ru/news/2023/07/30/delta/', -6649428379384196874);
INSERT INTO public."NewsRss" VALUES (71325, 'Забросавший яйцами российское посольство в Эстонии оказался журналистом Бабченко', '
    Эстонские полицейские задержали мужчину 1977 года рождения, который забросал яйцами стену посольства Российской Федерации в Таллине. По данным издания Delfi, задержанный является бывшим российским журналистом Аркадием Бабченко (признан в РФ иноагентом).
  ', 1690744740, 'https://lenta.ru/news/2023/07/30/babchenko/', 3162023238282007302);
INSERT INTO public."NewsRss" VALUES (71326, 'Упавший под Таганрогом беспилотник сняли на видео', '
    Упавший в хуторе Дарагановка под Таганрогом Ростовской области неопознанный беспилотник сняли на видео. На сделанных очевидцами кадрах видны обломки дрона, лежащие на дороге. Также показывается, как местные жители поливают горящий беспилотник из шланга.
  ', 1690744620, 'https://lenta.ru/news/2023/07/30/vid_bpla/', 8397386660464378868);
INSERT INTO public."NewsRss" VALUES (71327, 'Губернатор подтвердил падение беспилотника под Таганрогом', '
    Губернатор Ростовской области Василий Голубев подтвердил падение беспилотника в хуторе Дарагановка Неклиновского района. Как рассказал Голубев, в результате произошедшего повреждена кровля частного дома и автомобиль. «Бригада скорой медпомощи выехала на место, но пострадавших пока не зафиксировано», — добавил он.
  ', 1690744140, 'https://lenta.ru/news/2023/07/30/tgn/', -6607594170339642248);
INSERT INTO public."NewsRss" VALUES (71328, 'В матче между «Ахматом» и ЦСКА все пять голов забили с пенальти', '
    Московский ЦСКА одержал победу над грозненским «Ахматом» в матче второго тура Российской премьер-лиги (РПЛ). Встреча прошла в Грозном на стадионе «Ахмат-Арена» и завершилась со счетом 3:2. Все пять голов забили с пенальти. В матче было два удаления. Нападающий ЦСКА Федор Чалов сделал хет-трик. 
  ', 1690743840, 'https://lenta.ru/news/2023/07/30/rpl/', -6607234708957383560);
INSERT INTO public."NewsRss" VALUES (71329, 'В Крыму пообещали Западу ответные меры в случае нападения на полуостров', '
    Запад столкнется с последствиями в случае попытки захватить Крым, предупредил представитель Крымской межнациональной миссии Заур Смирнов. Он подчеркнул, что подобные действия обернутся катастрофой для всей Европы и Украины. Смирнов также добавил, что жители полуострова считают его символом современной России.
  ', 1690743840, 'https://lenta.ru/news/2023/07/30/krym_ataka/', 9101585046207708491);
INSERT INTO public."NewsRss" VALUES (71330, 'Посольство России в Таллине забросали яйцами', '
    Мужчина забросал яйцами стену здания посольства России в Таллине. Об этом сообщили в пресс-службе эстонского департамента полиции и погранохраны. Полиция задержала правонарушителя, им оказался мужчина 1977 года рождения. Против задержанного возбуждено уголовное дело. Другие подробности произошедшего не разглашаются.
  ', 1690743180, 'https://lenta.ru/news/2023/07/30/egg/', -6610954369947487112);
INSERT INTO public."NewsRss" VALUES (71331, 'В Киеве назвали срок начала переговоров с США по гарантиям безопасности', '
    Глава офиса украинского президента Андрей Ермак заявил, что переговоры с США по гарантиям безопасности состоятся уже на следующей неделе. «Эти гарантии будут действовать до вступления Украины в НАТО, что является самой надежной гарантией безопасности», — говорится в сообщении.
  ', 1690742640, 'https://lenta.ru/news/2023/07/30/peregovori/', -5785064006806946362);
INSERT INTO public."NewsRss" VALUES (71332, 'Венгрия обвинила Словакию во лжи из-за заявления о сроках конфликта на Украине', '
    Заявление министра иностранных дел Словакии Мирослава Влаховского о том, что Евросоюз не обсуждал сроки продолжения конфликта на Украине, не соответствует действительности. Об этом сообщил госсекретарь МИД Венгрии по двусторонним отношениям Тамаш Менцер.
  ', 1690742460, 'https://lenta.ru/news/2023/07/30/hungary_slovakia/', 56862470946865864);
INSERT INTO public."NewsRss" VALUES (71333, 'Под Таганрогом упал неопознанный беспилотник', '
    На хуторе Дарагановка под Таганрогом упал неопознанный беспилотник. В результате ЧП начался пожар, горят дом и автомобиль. Предварительно, пострадал один человек. Принадлежность БПЛА устанавливается.
  ', 1690741920, 'https://lenta.ru/news/2023/07/30/tgnrg/', -6647918068685319946);
INSERT INTO public."NewsRss" VALUES (71334, 'В Польше футбольному фанату порвали шарф из-за русской речи', '
    Белорусский болельщик футбольного клуба «Шленск» заявил, что после матча второго тура чемпионата Польши по футболу с «Заглембе» ему порвали шарф из-за русской речи. Он отметил, что не собирается требовать новый шарф, но выразил мнение, что судить о людях только по языку, на котором они говорят, является плохим подходом
  ', 1690741560, 'https://lenta.ru/news/2023/07/30/scarf/', -6648322725761236746);
INSERT INTO public."NewsRss" VALUES (71335, 'В Москве загорелась летняя веранда ресторана', '
    Летняя веранда ресторана I like Wine загорелась на улице Покровка в Москве вечером 30 июля. По информации Telegram-канала «Новости Москвы», причиной произошедшего стало возгорание уличного газового обогревателя. Как сообщает Telegram-канал РБК, на данный момент огонь уже потушили.
  ', 1690741320, 'https://lenta.ru/news/2023/07/30/verr/', 2042854531656644276);
INSERT INTO public."NewsRss" VALUES (72368, 'Крымский мост защитили от терактов', '
    Крымский мост оградили специальными противодиверсионными боновыми заграждениями. Таким образом постройку хотят дополнительно защитить от возможных терактов с использованием надводных и подводных дронов. в перспективе такие конструкции будут оборонять мост от атак на всей его протяженности.
  ', 1690790240, 'https://lenta.ru/news/2023/07/31/bon_most/', -8371662383918789359);
INSERT INTO public."NewsRss" VALUES (71336, 'В Чехии арестовали отель российского миллиардера', '
    Власти Чехии арестовали отель, принадлежащий российскому миллиардеру Владимиру Евтушенкову, сообщает «Чешское телевидение». Пятизвездочный Savoy Westend находится на курокте Карловы Вары. Стоимость объекта оценивается в 4,6 миллиона долларов. Сейчас отель принимает лишь тех гостей, кто оплатил проживание до конца июня.
  ', 1690741020, 'https://lenta.ru/news/2023/07/30/otel/', 2038602678732388020);
INSERT INTO public."NewsRss" VALUES (71337, 'В США заявили об успехах армии России в боевых действиях на Украине', '
    Российские средства радиоэлектронной борьбы (РЭБ) мешают украинской армии проводить военные операции, заявил бывший советник главы Пентагона полковник Дуглас Макгрегор. По его словам, использование российскими войсками средств РЭБ сильно влияет на способность противника воевать. 
  ', 1690740780, 'https://lenta.ru/news/2023/07/30/vsu_reb/', 9055209711646364127);
INSERT INTO public."NewsRss" VALUES (71338, 'Вероятность вмешательства других стран в ситуацию в Нигере оценили', '
    Сообщество стран Западной Африки (ЭКОВАС) может ввести силы в Нигер после попытки госпереворота, считает ведущий научный сотрудник Института стран Азии и Африки МГУ, профессор ВШЭ Николай Щербаков. В разговоре с «Лентой.ру» он объяснил, почему стабильность этого государства важна для его соседей.
  ', 1690739700, 'https://lenta.ru/news/2023/07/30/niger/', -6655837971064180490);
INSERT INTO public."NewsRss" VALUES (71339, 'Талибы конфисковали и сожгли музыкальные инструменты', '
    На Западе Афганистана в провинции Герат подразделение министерства исламской ориентации конфисковало и сожгло музыкальные инструменты. Представители министерства заявили, что продажа и использование любых музыкальных инструментов запрещаются религией, отметив, что нарушителей ждут серьезные юридические последствия. 
  ', 1690739400, 'https://lenta.ru/news/2023/07/30/gerat/', -6655176218689306378);
INSERT INTO public."NewsRss" VALUES (71340, 'Иностранный футболист объяснил желание получить российское гражданство', '
    Аргентинский полузащитник «Оренбурга» Лукас Вера объяснил желание получить российское гражданство. Футболист заявил, что это поможет ему оказаться в сборной России, а также платить меньше налогов. «Мне предложили это сделать, и я согласился. Это достаточно неплохо для моего будущего», — подчеркнул он.
  ', 1690738500, 'https://lenta.ru/news/2023/07/30/vera/', 2035764880680744628);
INSERT INTO public."NewsRss" VALUES (71341, 'На Украине анонсировали обсуждение «формулы мира»', '
    Глава офиса президента Украины Андрей Ермак анонсировал встречу по реализации «формулы мира», обсуждение инициативы должно пройти в Саудовской Аравии. На предстоящем саммите должны собраться советники глав ряда государств, однако участие России во встрече не планируется. 
  ', 1690738440, 'https://lenta.ru/news/2023/07/30/ermak/', -6649986582038781706);
INSERT INTO public."NewsRss" VALUES (71342, 'В США предложили создать сопоставимую с НАТО структуру', '
    Чтобы решать современные проблемы, нужно создать новую трансатлантическую структуру по типу НАТО, в которой будут участвовать США и Евросоюз. С таким предложением выступил бывший американский посол в Евросоюзе Стюарт Айзенштадт. Он также предложил каждый год устраивать саммиты ЕС — США. 
  ', 1690737960, 'https://lenta.ru/news/2023/07/30/exposol/', -3268839685461496170);
INSERT INTO public."NewsRss" VALUES (71343, 'В Нигере призвали к митингам за освобождение президента', '
    Правящая партия Нигера «Нигерская партия за демократию и социализм» призвала устроить митинги за освобождение президента Мохамеда Базума, которого свергли в результате военного переворота. В это время в стране проходят демонстрации сторонников оппозиции, они вышли на митинги с флагами, в том числе российскими. 
  ', 1690737360, 'https://lenta.ru/news/2023/07/30/meeting/', 769532820821528427);
INSERT INTO public."NewsRss" VALUES (71344, 'Госскеретарь США оценил угрозу ядерной войны', '
    Госсекретарь США Энтони Блинкен считает, что потенциальная угроза от ядерной войны не опаснее проблемы изменения климата. По его мнению, потенциальный конфликт сейчас централен, он сравнил его с волком у двери, однако вопросы климата представляют «экзистенциальный вызов для всех нас». 
  ', 1690736520, 'https://lenta.ru/news/2023/07/30/yader/', -6655837958891462410);
INSERT INTO public."NewsRss" VALUES (71408, 'Власти России нашли новый способ сократить расходы бюджета', '
    Минфин предложил новый метод контроля за расходом бюджетных средств — наблюдать за госучреждениями «тайно», без предупреждения о проверке. Новый метод заключается в сборе и анализе данных об объекте контроля, содержащихся в информационных ресурсах и внешних источниках. 
  ', 1690789875, 'https://lenta.ru/news/2023/07/31/taino/', 6246574017121898743);
INSERT INTO public."NewsRss" VALUES (73018, 'В России высказались о причастности Британии к теракту на Крымском мосту', '
    Британские спецслужбы причастны ко многим операциям против России, которые проводит сегодня Украина, считает первый заместитель председателя комитета Совета Федерации по международным делам Владимир Джабаров. Так в беседе с «Лентой.ру» он высказался о причастности королевства к теракту на Крымском мосту.
  ', 1690790719, 'https://lenta.ru/news/2023/07/31/most_krim/', -3217730601874531316);
INSERT INTO public."NewsRss" VALUES (73085, '[Перевод] Неизвестный атрибут 28 — источник энтропии в междоменной маршрутизации?', '2 июня 2023 года произошел сбой в работе междоменной маршрутизации сети интернет. Мы получили уведомление о периодических перезагрузках некоторых роутеров, отвечающих за маршрутизацию между сетями, из-за некорректных BGP-пакетов с BGP-атрибутом 28. Здесь мы начнем рассмотрение этого события с помощью RIS и представим предварительные соображения о том, что могло пойти не так. Читать далее', 1690721341, 'https://habr.com/ru/companies/otus/articles/751198/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751198', -6452356545240132128);
INSERT INTO public."NewsRss" VALUES (73327, 'Россиянка вонзила нож в живот поздно вернувшемуся домой супругу', '
    В Архангельской области суд рассмотрит дело 42-летней местной жительницы, изрезавшей 45-летнего супруга. Утром 24 декабря 2022 года в деревне Пловская фигурантка поссорилась с мужем и вонзила нож ему в живот. Россиянка сама вызвала скорую помощь. Во время допроса женщина признала вину.
  ', 1690790958, 'https://lenta.ru/news/2023/07/31/arhisres/', 1232561173259217056);
INSERT INTO public."NewsRss" VALUES (73332, 'Складные смартфоны Samsung появились в России раньше времени', '
    Флагманские складные смартфоны Samsung заметили в российской рознице. Журналисты агентства заметили, что складные аппараты Galaxy Z Fold5 и Galaxy Z Flip5 уже начали продавать в России. По словам специалистов, новые гаджеты появились на рынке раньше времени — на две недели до старта мировых продаж.
  ', 1690790900, 'https://lenta.ru/news/2023/07/31/uzhe_tut/', -2856719368035325779);
INSERT INTO public."NewsRss" VALUES (73649, 'На пляже в Сочи прошли «Снежные старты»', '
    На пляже «Роза Хутор» в Сочи прошли соревнования по лыжному спорту и сноубордингу «Снежные старты». Об этом сообщает портал «Кубанские новости». Состязания состоялись на берегу моря 30 июля. Специально для них на пляж с гор доставили около 50 кубометров снега — из него соорудили гору высотой 10 метров.
  ', 1690790968, 'https://lenta.ru/news/2023/07/26/snejnie/', 4371048368142696488);
INSERT INTO public."NewsRss" VALUES (73968, 'Минобороны показало видео уничтожения наблюдательного пункта ВСУ', '
    Российская армия уничтожила на купянском направлении наблюдательный пункт Вооруженных сил Украины (ВСУ). Соответствующее видео опубликовало Министерство обороны России. Расчет переносного противотанкового комплекса управляемой ракетой попал по наблюдательному пункту ВСУ.
  ', 1690791242, 'https://lenta.ru/news/2023/07/31/kupiansknp/', -4522107575848990611);
INSERT INTO public."NewsRss" VALUES (74607, 'Россиянкам назвали способ визуально удлинить ноги с помощью одежды', '
    Стилистка и имиджмейкер Мария Абабкова назвала россиянкам способ визуально удлинить ноги с помощью одежды. Зрительно скорректировать фигуру, сделав ее стройнее, помогут предметы гардероба с завышенной талией. Так, для достижения данной цели следует выбирать юбки макси из джинсовой ткани.
  ', 1690791544, 'https://lenta.ru/news/2023/07/31/leglengthening/', -4426786328804516745);
INSERT INTO public."NewsRss" VALUES (74930, 'Находившаяся 14 лет в плену у маньяка россиянка рассказала подробности побега', '
    Сбежавшая от маньяка после 14-лет плена россиянка рассказала подробности о своем побеге. По словам пленницы, бежать ей помогла мать маньяка. После того, как он в очередной раз сильно напился и пригрозил матери ножом, пенсионерка вызвала психиатрическую помощь и сообщила пленнице, что это ее шанс.
  ', 1690791762, 'https://lenta.ru/news/2023/07/31/rasskaz/', -3909878094737118791);
INSERT INTO public."NewsRss" VALUES (75634, '[Перевод] Будущее iOS-разработки на Flutter', 'Hola, Amigos! На связи Саша Чаплыгин, Flutter-dev компании Amiga.В этой статье вы узнаете о последних достижениях и будущем приоритете в улучшении Flutter, как инструмента для разработки iOS-приложений. Читать далее', 1690790855, 'https://habr.com/ru/articles/750818/?utm_source=habrahabr&utm_medium=rss&utm_campaign=750818', -1037291288394235996);
INSERT INTO public."NewsRss" VALUES (75887, 'Квадрокоптер упал недалеко от жилого дома на юго-западе Москвы', '
    Гражданский квадрокоптер упал недалеко от жилого дома, расположенного на Чонгарском бульваре на юго-западе Москвы. Собеседник агентства ТАСС отметил, что сейчас территорию оцепили. 
  ', 1690792311, 'https://lenta.ru/news/2023/07/31/kopterss/', -9171315129235796431);
INSERT INTO public."NewsRss" VALUES (75892, 'Судебные расходы Трампа превысили 40 миллионов долларов', '
    Судебные расходы комитета политических действий бывшего президента США Дональда Трампа превысили 40,2 миллиона долларов в первой половине 2023 года. Директор по связям с общественностью Эндрю Ромео прокомментировал эту информацию, отметив, что судебные издержки не помогут республиканцам вернуть себе Белый дом.
  ', 1690792308, 'https://lenta.ru/news/2023/07/31/40/', -8007575711583536975);
INSERT INTO public."NewsRss" VALUES (76208, 'Галустян о нежелании Харламова общаться с ним', '
    Комик, актер и телеведущий Михаил Галустян признался, что сейчас практически не общается с коллегой Гариком Харламовым, и назвал причину этого. Шоумен также отметил, что у него с коллегой «хорошие отношения, которых нет». Перед этим Галустян объяснил нежелание стать участником реалити-шоу «Новые звезды в Африке». 
  ', 1690792466, 'https://lenta.ru/news/2023/07/31/gal_harl/', -5073761472636170631);
INSERT INTO public."NewsRss" VALUES (76530, 'Россиянка нашла в лесу гигантские грибы-зонтики', '
    Жительница Екатеринбурга отправилась в лес и обнаружила гигантские грибы-зонтики. Фотографиями своих находок она поделилась в соцсетях, внимание на них обратил портал E1.RU. По словам женщины, снимки были сделаны во время похода в лес 30 июля. Она отметила, что впервые встретила грибы такого размера.
  ', 1690792800, 'https://lenta.ru/news/2023/07/26/gribiii/', -8601218532434702219);
INSERT INTO public."NewsRss" VALUES (76535, 'ВС России нанесли удар по пункту ВСУ в районе Антоновского моста', '
    Вооруженные силы России нанесли удар по наблюдательному пункту украинских войск в районе Антоновского моста. Российские десантники обнаружили цель в полуразрушенном доме, выдвинулись к месту на автомобиле «багги» с противотанковым ракетным комплексом «Корнет» и уничтожили цель ударом управляемой ракеты.
  ', 1690792615, 'https://lenta.ru/news/2023/07/31/minoborony/', 3949485927882734264);
INSERT INTO public."NewsRss" VALUES (76845, 'Медведев назвал позволяющий довести СВО до конца фактор', '
    Отказ Киева от переговоров позволит довести специальную военную операцию (СВО) до конца. Об этом в своем Telegram-канале заявил заместитель председателя Совета безопасности России Дмитрий Медведев.
  ', 1690792905, 'https://lenta.ru/news/2023/07/31/dokonca/', 2857817577307660679);
INSERT INTO public."NewsRss" VALUES (76850, 'Селена Гомес показала новые снимки в купальнике', '
    Американская певица и актриса Селена Гомес показала новые фото в откровенном образе. 30-летняя знаменитость опубликовала серию снимков, на которых она позирует на лодке в купальнике розового цвета и расстегнутых джинсах с завышенной линией талии. При этом волосы поп-исполнительница распустила.
  ', 1690792897, 'https://lenta.ru/news/2023/07/31/selenakupi/', -5309371959461375498);
INSERT INTO public."NewsRss" VALUES (76855, 'Россия примет участие в турнире развития УЕФА в сентябре', '
    Юниорские сборные России по футболу примут участие в турнире развития УЕФА в сентябре 2023 года. «Он [турнир] пройдет в Минске. В нем также примут участие команды Белоруссии, Таджикистана, Узбекистана», — заявил генеральный секретарь Российского футбольного союза Максим Митрофанов.
  ', 1690792843, 'https://lenta.ru/news/2023/07/31/uefa_russia/', 4354650260848827245);
INSERT INTO public."NewsRss" VALUES (77168, 'Турция потребовала от Запада гарантий по зерновой сделке', '
    Турция хочет получить гарантии от Запада по снятию ограничений с экспорта российской агропродукции для возобновления зерновой сделки. По словам источника РИА Новости в Анкаре, турецкая сторона на переговорах добивается от западных партнеров конкретных гарантий, поскольку их отсутствие уже привело к остановке сделки.
  ', 1690793035, 'https://lenta.ru/news/2023/07/31/zerno_sdelka_ankara/', 2384986878888533204);
INSERT INTO public."NewsRss" VALUES (77173, 'Пушилин рассказал об ожесточенных боях на флангах под Артемовском', '
    На флангах под Артемовском, а также возле Клещеевки идут ожесточенные бои. Об этом рассказал врио главы Донецкой народной республики Денис Пушилин. По его словам Артемовск подвергается ежедневным хаотичным обстрелам. На флангах Вооруженные силы Украины периодически занимают позиции, но их выбивают оттуда. 
  ', 1690793018, 'https://lenta.ru/news/2023/07/31/pushilin/', 2242252240535178484);
INSERT INTO public."NewsRss" VALUES (77495, 'Жилье в Сочи подешевело', '
    За неполный 2023 года новостройки в Сочи подешевели на 13 процентов. С января по июль стоимость квадратного метра на рынке первичного жилья Сочи снизилась на 51,5 тысячи рублей. Город стал лидером по снижению цен на новостройки. Сейчас «квадрат» в новой сочинской квартире оценивается в 341,7 тысячи рублей.
  ', 1690793316, 'https://lenta.ru/news/2023/07/31/novostr_soch/', -3948003283807457074);
INSERT INTO public."NewsRss" VALUES (78752, 'В епархии опровергли данные о разрушении колокольни после бури в Челябинске', '
    30 июля в паблике «Мой Православный Миасс» во «ВКонтакте» появилось сообщение, что  после сильнейшей бури рухнула колокольня Свято-Семионовской церкви в Челябинске. Однако информация не подтвердилась. 
  ', 1690795440, 'https://lenta.ru/news/2023/07/31/pravoslavie/', 3379347747386944240);
INSERT INTO public."NewsRss" VALUES (77806, 'Перечислены основные характеристики iPhone 15', '
    Обозреватель Bloomberg Марк Гурман перечислил характеристики новых смартфонов Apple. Специалист выяснил, что топовые модели серии — iPhone 15 Pro и 15 Pro Max — получат дисплеи, созданные по технологии LIPO. Это позволит уменьшить размер рамок с 2,2 до 1,5 миллиметра. Apple анонсирует новые телефоны в сентябре.
  ', 1690793433, 'https://lenta.ru/news/2023/07/31/iphone15_specs/', 8433765828118220891);
INSERT INTO public."NewsRss" VALUES (78125, 'Страна НАТО по ошибке опубликовала секретные военные карты', '
    Минобороны Греции инициировало проверки на складах боеприпасов, пострадавших в результате пожаров, и по ошибке опубликовало фотографии секретных военных карт. Во время одной из поездок замминистра обороны страны секретные карты попали на фото, которое приложили к пресс-релизу.
  ', 1690793625, 'https://lenta.ru/news/2023/07/31/secretsout/', -6794905784217047367);
INSERT INTO public."NewsRss" VALUES (78130, 'Вероятность восстановления промышленности ЕС без российского газа оценили', '
    Аналитик Игорь Юшков заявил, что для восстановления европейской промышленности необходима стабильность цен на электроэнергию, поскольку в противном случае бизнес лишается возможности планирования и долгосрочных инвестиций. Достижение стабильности в текущий момент без российского газа практически невозможно. 
  ', 1690793614, 'https://lenta.ru/news/2023/07/31/gz/', -8016981827400730447);
INSERT INTO public."NewsRss" VALUES (78135, 'По факту атаки беспилотников в Московском регионе возбудили дело', '
    По факту атаки беспилотников в Московском регионе возбудили дело. 
  ', 1690793567, 'https://lenta.ru/news/2023/07/31/mosregiom/', -3217726669112559188);
INSERT INTO public."NewsRss" VALUES (78142, 'На Алтае спасли упавшую в яму обессилевшую корову', '
    В селе Шебалино Республики Алтай спасли корову, которая провалилась в глубокую яму и выбилась из сил. Об этом сообщает «МК» со ссылкой на региональное управление по гражданской обороне, чрезвычайным ситуациям и пожарной безопасности. Как отмечается, обессилившее животное в яме случайно обнаружили местные жители.
  ', 1690793547, 'https://lenta.ru/news/2023/07/11/spasli_korovu/', 7788868396842604108);
INSERT INTO public."NewsRss" VALUES (78448, 'Шесть родственников попали в больницу после тантрического ритуала с ямой', '
    В Индии семья устроила тантрический ритуал, чтобы поправить здоровье, и оказалась в больнице. Помощь врачей понадобилась семье из шести человек в округе Пратапгарх, штата Уттар-Прадеш. Они пригласили четверых мастеров тантры из города Джаунпур, так как все страдали от неких заболеваний.
  ', 1690793825, 'https://lenta.ru/news/2023/07/31/tantra/', -3665224570503578544);
INSERT INTO public."NewsRss" VALUES (78453, 'Трое пьяных пассажиров устроили дебош на борту и сорвали рейс на Бали', '
    Трое пассажиров самолета авиакомпании Virgin Australia напились на борту, устроили дебош и сорвали рейс. Рейс из Брисбена на Бали был перенаправлен в австралийский город Дарвин после того, как трое пассажиров превратили полет в хаос. Члены экипажа сообщили полиции, что они находились в состоянии алкогольного опьянения.
  ', 1690793741, 'https://lenta.ru/news/2023/07/31/troubleonboard/', -5252699373115827013);
INSERT INTO public."NewsRss" VALUES (78732, 'Появилось видео уничтожения бронетехники ВСУ на запорожском направлении', '
    Российский разведывательно-ударный вертолет Ка-52 уничтожил бронетехнику Вооруженных сил Украины на запорожском направлении. В Минобороны России уточнили, что экипаж вертолета нанес удар управляемой ракетой по выдвигающейся бронетехнике украинских войск. В результате прямого попадания была поражена бронемашина ВСУ. 
  ', 1690795890, 'https://lenta.ru/news/2023/07/31/bronvsu/', -3912261488559214478);
INSERT INTO public."NewsRss" VALUES (78738, 'В России оценили планы Эр-Рияда провести мирные переговоры по Украине без Москвы', '
    Планы Саудовской Аравии провести мирные переговоры по Украине без участия Москвы, о которых ранее писало издание The Wall Street Journal, невозможно воплотить, так как пытаться добиться урегулирования нельзя без России. 
  ', 1690795489, 'https://lenta.ru/news/2023/07/31/riyadh_plans/', -5213127799479002066);
INSERT INTO public."NewsRss" VALUES (78745, 'Бородина преподнесла семилетней дочери подарок за 210 тысяч рублей', '
    Российская телеведущая Ксения Бородина показала роскошный подарок для семилетней дочери Теоны. Знаменитость разместила видео из магазина люксового бренда Prada, который расположен в Париже. Телезвезда преподнесла девочке голубую сумку из сафьяновой кожи стоимостью  2300 долларов (210 тысяч рублей).
  ', 1690795485, 'https://lenta.ru/news/2023/07/31/210kteona/', 3800180540053921522);
INSERT INTO public."NewsRss" VALUES (78750, 'Взрыв в российском городе повредил восемь гаражей', '
    В Волгодонске Ростовской области произошел взрыв в гаражном кооперативе. Об этом сообщает Telegram-канал Don Mash. По данным авторов канала, из-за взрыва оказались повреждены восемь гаражей и одна машина. Под завалами может находиться один человек. Соседи утверждают, что собственником гаража является 55-летний мужчина.
  ', 1690795440, 'https://lenta.ru/news/2023/07/31/vzriv/', 6244097935260201207);
INSERT INTO public."NewsRss" VALUES (78760, 'Польша отправила снайперов на белорусскую границу', '
    Польша отправила снайперов на границу с Белоруссией, сообщило Генеральное командование ВС Польши. «Снайперы — мастера разведки, навигации, работы с оружием. Для них характерны уверенность в себе, терпение», — отмечается в публикации генштаба под фото, на котором запечатлены польские снайперы с оружием на границе.
  ', 1690795402, 'https://lenta.ru/news/2023/07/31/polskiyesnaypei/', 2807945168213016033);
INSERT INTO public."NewsRss" VALUES (78765, 'Heineken пожаловался на сложности с продажей бизнеса в России', '
    В нидерландском пивоваренном концерне Heineken заявили об усложнении условий выхода из российских активов. Компания подала заявку на одобрение сделки по продаже активов еще в апреле 2023 года, однако к настоящему времени до сих пор не закрыла сделку. На этом фоне произошло обесценивание активов на 201 миллиона евро. 
  ', 1690795396, 'https://lenta.ru/news/2023/07/31/heineken_russia/', 1118641505239364640);
INSERT INTO public."NewsRss" VALUES (78767, 'В Москве спрогнозировали температуру выше 30 градусов', '
    Погода в течение недели в Москве и области будет комфортной, температурный фон превысит норму на 2-4 градуса, рассказал научный руководитель Гидрометцентра Роман Вильфанд. Прогнозом он поделился в беседе с «Лентой.ру». По словам синоптика, теплая погода будет обусловлена перемещением воздушных масс с юга.
  ', 1690795200, 'https://lenta.ru/news/2023/07/31/pogoda/', -3665192220205409648);
INSERT INTO public."NewsRss" VALUES (78774, 'Мужчина избил и изнасиловал россиянку в лесу', '
    В Петербурге мужчина избил и изнасиловал девушку в лесу. Потерпевшая рассказала, что утром 29 июля малознакомый мужчина напал на нее и надругался в лесополосе.  На следующий день силовики задержали фигуранта. Против него составили протокол об административном правонарушении. 
  ', 1690794942, 'https://lenta.ru/news/2023/07/31/piterles/', 8291109083192670452);
INSERT INTO public."NewsRss" VALUES (78777, 'Россияне начали экономить на салонах красоты', '
    Выручка салонов красоты, а также туристических и маркетинговых агентств за первую половину 2023 года упала вдвое по сравнению с тем же периодом прошлого года. К концу первого квартала 2023-го салоны красоты и спа заработали на 72,82 процента меньше в годовом выражении.
  ', 1690794897, 'https://lenta.ru/news/2023/07/31/no_more_beauty/', -5254939789189336540);
INSERT INTO public."NewsRss" VALUES (78782, 'Глава Запорожской области сообщил об уменьшении обстрелов ВСУ', '
    Вооруженные силы Украины (ВСУ) снизили интенсивность обстрелов населенных пунктов Запорожской области, сообщил врио главы российского региона Евгений Балицкий. Он также указал, что за последние сутки украинская армия совершила 86 попыток ударов по региону на пологовском, токмакском и васильевском направлениях.
  ', 1690794890, 'https://lenta.ru/news/2023/07/31/balitskyzap/', 4707609464403393252);
INSERT INTO public."NewsRss" VALUES (78788, 'Российские ученые создадут электронный дегустатор кофе', '
    Ученые Сибирского федерального университета (СФУ) из Красноярска создадут электронный дегустатор кофе. Об этом сообщил ТАСС заведующий лабораторией сити-фарминга Института гастрономии СФУ Иван Тимофеенко. По его словам, российские специалисты уже занимаются разработкой на средства гранта.
  ', 1690794840, 'https://lenta.ru/news/2023/07/13/degustator/', -4638142123691574755);
INSERT INTO public."NewsRss" VALUES (78791, 'В России вырастут цены на автозапчасти', '
    Автозапчасти подорожали с начала 2023 года на 20-30 процентов, при этом цены могут продолжить расти, считают российские автодилеры. До конца года из-за ослабления рубля цены на запчасти для автомобилей европейского, корейского и японского производства могут повыситься еще на 20-25 процентов.
  ', 1690794673, 'https://lenta.ru/news/2023/07/31/zapchasti/', 8212887734089700126);
INSERT INTO public."NewsRss" VALUES (78795, 'Книга по Open Source процессору спутниковой интерферометрии PyGMTSAR (Python InSAR)', 'Почти четверть века назад я занимался моделированием интерференции и голографии в оптических нелинейных средах — попросту говоря, фотополимерах — а сегодня в качестве хобби разрабатываю открытый InSAR процессор PyGMTSAR. Если вам покажется странным, почему в качестве хобби, то это просто — потому, что я могу сделать продукт лучше, чем аналоги от НАСА (JPL ISCE) и Европейского космического агенства (SNAP), а вот гранты на разработку они выдают гражданам США и Евросоюза (коим я не являюсь). Что касается российской науки, то лишь спустя десятилетие после окончания университета я случайно узнал (гугл показал ссылку на меня же в запросе, связанном с интерферограммами в фотополимерах), что моя магистерская работа заняла первое место во всероссийском конкурсе, где ННГУ им. Лобачевского из Нижнего Новгорода, кажется, и вовсе не появлялся (хотя после выпуска и завершения конкурса я еще работал в университете, я даже не знал, что мою работу отправляли на всероссийский конкурс). Наверное, это вполне объясняет, почему же мне интересна тема InSAR. А вот к фотополимерным принтерам, которые с тех пор стали мейнстримом, душа не лежит и мне гораздо интереснее именно теоретическая часть моей давней работы, которая и является основой спутниковой интерферометрии. На хабре я уже публиковал серию статей на русском языке по обработку данных с радарных спутников Sentinel-1, а для тех, кто хочет подробнее, предлагаю обратиться к моей электронной книге на английском. Она доступна во многих онлайн издательствах, включая Амазон, а также значительная часть контента опубликована в открытом PDF (также другие главы можно найти в моих постах на линкедин, когда я выкладывал драфты в процессе написания книги).
 Читать дальше &rarr;', 1690792268, 'https://habr.com/ru/articles/751438/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751438', -1037289736829960284);
INSERT INTO public."NewsRss" VALUES (78798, 'Власти России объяснили необходимость фронтального сокращения расходов бюджета', '
    Министр финансов России Антон Силуанов объяснил необходимость фронтального сокращения расходов бюджета 2024 года по незащищенным статьям «финансово емкими задачами» в следующем году. Министр заявил, что ожидаемое снижение на 10 процентов — это «не сокращение, а перераспределение, приоритизация расходов на новые цели».
  ', 1690794540, 'https://lenta.ru/news/2023/07/31/budget/', -3657223451654724880);
INSERT INTO public."NewsRss" VALUES (78802, 'Грузию убрали из списка остановок маршрутов круизного лайнера с россиянами', '
    Грузию убрали из списка остановок маршрута круизного лайнера Astoria Grande. Как сообщает РИА Новости, судно с россиянами больше не будет останавливаться в Батуми. Организаторы круизов в офисе продаж билетов пока официально не подтвердили эту информацию. Кроме того, неизвестно, что стало причиной отмены.
  ', 1690794480, 'https://lenta.ru/news/2023/07/31/batumi/', -3661686816211623184);
INSERT INTO public."NewsRss" VALUES (78806, 'Bercut птица гордая, не пнешь…', 'Эта статья о моем опыте импортозамещения в сфере сертифицированного измерительного оборудования, а именно использование приборов Bercut‑ETX 10G компании ООО «НТЦ‑Метротек». Полагаю, что&nbsp;информация в&nbsp;статье будет любопытна коллегам трудящимся в&nbsp;близких областях. Читать далее', 1690792831, 'https://habr.com/ru/articles/751444/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751444', -1039897847130521692);
INSERT INTO public."NewsRss" VALUES (78815, 'В Британии рассказали о менее 50 исправных танках на всю армию', '
    Британская армия может располагать менее чем 50 исправными танками Challenger 2 на всю армию из-за многолетней политики сокращения оборонных расходов. Такое предположение сделал глава комитета по обороне Палаты общин (нижней палаты парламента) Тобиас Эллвуд. В период с 2010 по 2014 год Британия избавилась от 43 танков.
  ', 1690794120, 'https://lenta.ru/news/2023/07/31/50/', -8007573993596618575);
INSERT INTO public."NewsRss" VALUES (78821, 'Катер проехался по 12-летней россиянке и перерубил ей ноги', '
    В Самарской области водитель катера перерубил ноги 12-летней девочке. Она потеряла много крови и находится в реанимации. Инцидент произошел днем 30 июля. Россиянка купалась на реке Сок недалеко от села Малая Царевщина. Неожиданно рядом с ней пронесся катер белого цвета, зацепив ноги ребенка.
  ', 1690794000, 'https://lenta.ru/news/2023/07/31/kater/', 6242471464091435255);
INSERT INTO public."NewsRss" VALUES (78826, 'Стали известны детали событий первого дня Московского урбанфорума в «Лужниках»', '
    В день открытия Московского урбанистического форума (МУФ-2023) на площадке в «Лужниках» пройдет более ста событий. 1 августа гости смогут увидеть выступления музыкантов и цирковых артистов, посетить мастер-классы, принять участие в соревнованиях и поиграть в настольные игры.
  ', 1690794000, 'https://lenta.ru/news/2023/07/31/sobytiya/', -7000670184150735279);
INSERT INTO public."NewsRss" VALUES (78807, 'Украинский скульптор призвал сохранить герб СССР с монумента «Родины-матери»', '
    Украинский скульптор Алексей Пергаменщик призвал сохранить герб СССР с монумента «Родины-матери» в Киеве. По словам монументалиста, герб можно разрезать по швам, затем вновь сварить и разместить в темном зале, расположенном под мемориалом. Ранее сообщалось о демонтаже герба СССР с монумента.
  ', 1690794360, 'https://lenta.ru/news/2023/07/31/sculptor_prizyv/', -1878696784071914301);
INSERT INTO public."NewsRss" VALUES (78811, '«АвтоВАЗ» начнет производить больше дешевых Lada', '
    «АвтоВАЗ» увеличит объем производства самых бюджетных модификаций Lada, цены на которые остаются в пределах 700 тысяч рублей, сообщил президент компании Максим Соколов. По его словам, клиенты ориентированы на покупку недорогих автомобилей, и надо предоставить им такую возможность.
  ', 1690794240, 'https://lenta.ru/news/2023/07/31/nedorogo/', 502622682286146559);
INSERT INTO public."NewsRss" VALUES (78818, 'Дизайнер не нужен. Правила создания красивых UI', '

Чем проще система — тем она эффективнее. Здесь не нужен художественный вкус или особая одарённость. Красота появляется сама собой, если система спроектирована без лишних деталей. Хороший пример таких интерфейсов дают рабочие инструменты. Молоток, ножовка, электропила. Всё это создано не для красоты, а чтобы идеально ложиться в руку и эффективно выполнять свою функцию. О красоте думают в последнюю очередь, но в итоге дизайн профессиональных инструментов зачастую вызывает искреннее восхищение. Ничего лишнего.

Такие же правила действуют в компьютерных интерфейсах. Чем проще — тем лучше. В этом смысле интересно посмотреть на новое поколение Linux-приложений в современном стиле с адаптацией под смартфоны (на КДПВ некоторые примеры), а также на свежие UI-фреймворки, которые продвигают современный стиль разработки. Читать дальше &rarr;', 1690794001, 'https://habr.com/ru/companies/ruvds/articles/750736/?utm_source=habrahabr&utm_medium=rss&utm_campaign=750736', -675281202152960934);
INSERT INTO public."NewsRss" VALUES (79050, 'ЮАР пригласили на мирные переговоры по Украине', '
    ЮАР пригласили на запланированные в Саудовской Аравии мирные переговоры по Украине, сообщил представитель офиса президента Южноафриканской Республики.
  ', 1690796200, 'https://lenta.ru/news/2023/07/31/sar/', -6603022830756494216);
INSERT INTO public."NewsRss" VALUES (79055, 'Кремль высказался о возможности повышения уровня терропасности в Москве', '
    Власти не планируют повышать уровень террористической опасности в Москве и Подмосковье. Такое заявление сделал официальный представитель Кремля Дмитрий Песков.
  ', 1690796169, 'https://lenta.ru/news/2023/07/31/terror/', -3658259518403412912);
INSERT INTO public."NewsRss" VALUES (79060, 'В IIHF высказались о контракте вернувшегося из армии Федотова с «Филадельфией»', '
    Глава IIHF Люк Тардиф заявил, что организации нужно время, чтобы принять решение по контракту вернувшегося из армии голкипера ЦСКА Ивана Федотова с «Филадельфией Флайерс». Ранее TSN сообщил, что в НХЛ и «Филадельфии» считают, что соглашение с россиянином должно быть расторгнуто.
  ', 1690796122, 'https://lenta.ru/news/2023/07/31/iihf/', 2036885646733276932);
INSERT INTO public."NewsRss" VALUES (79065, 'В Кремле оценили ход украинского контрнаступления', '
    Украинское контрнаступление не получается, успехов у Киева нет, заявил пресс-секретарь президента России Дмитрий Песков. 
  ', 1690796112, 'https://lenta.ru/news/2023/07/31/peskov3107/', -7454268887346085810);
INSERT INTO public."NewsRss" VALUES (79070, 'В Кремле прокомментировали новую атаку беспилотников на Москву', '
    Атака беспилотников на Москву, которая произошла в воскресенье, 30 июля, подтверждает сущность «киевского режима». Об этом заявил официальный представитель Кремля Дмитрий Песков.
  ', 1690796103, 'https://lenta.ru/news/2023/07/31/peskov/', -3657626247226230128);
INSERT INTO public."NewsRss" VALUES (79075, 'В Кремле оценили возможность мирного урегулирования ситуации на Украине', '
    Выход на мирное урегулирование в ситуации на Украине невозможен с учетом нынешней позиции Киева. Об этом заявил пресс-секретарь президента России Владимира Путина Дмитрий Песков.
  ', 1690796100, 'https://lenta.ru/news/2023/07/31/mirn/', 2038421252122670852);
INSERT INTO public."NewsRss" VALUES (79080, 'Россиян предупредили о способных изменить судьбу рисках при нанесении татуировок', '
    Врач-гепатолог Дмитрий Монахов предупредил, что при нанесении татуировок существует риск инфицирования гепатитом B или C. Он уточнил, что вирус может попасть в кровь, если иглы, которые используют для процедуры, были плохо обработаны. Также заразиться можно на приеме у стоматолога и при переливании крови.
  ', 1690796079, 'https://lenta.ru/news/2023/07/31/tattoo/', -3662921437578412976);
INSERT INTO public."NewsRss" VALUES (79085, 'На Украине объяснили причины роста коррупционных скандалов', '
    Причины роста количества коррупционных скандалов на Украине объяснили «идеальным штормом». Один из неназванных представителей украинской власти объяснил рост коррупции отсутствием побед Вооруженных сил Украины и дипломатических успехов. При этом перспективы возрождения экономики стали очень туманными.
  ', 1690795946, 'https://lenta.ru/news/2023/07/31/corruptionua/', 8844468630004766056);
INSERT INTO public."NewsRss" VALUES (79374, 'Стала известна дата переговоров Путина и Эрдогана', '
    Телефонный разговор президента России Владимира Путина и турецкого лидера Реджепа Тайипа Эрдогана планируется в среду, 2 августа. Об этом заявил пресс-секретарь президента РФ Дмитрий Песков.
  ', 1690796426, 'https://lenta.ru/news/2023/07/31/2/', -5911553992131300974);
INSERT INTO public."NewsRss" VALUES (79379, 'Google объяснила задержку обновлений для Android', '
    Инженеры корпорации Google объяснили, почему патчи безопасности выходят для Android-устройств с задержкой. Так, в Google рассказали, по какой причине патчи безопасности часто выходят на смартфонах с задержкой на несколько месяцев. В корпорации обвинили в этом производителей устройств, которые затягивают выпуск патчей.
  ', 1690796405, 'https://lenta.ru/news/2023/07/31/patch_gap/', -4186791240929094888);
INSERT INTO public."NewsRss" VALUES (79384, 'В Кремле оценили переговоры Эр-Рияда по Украине без участия России', '
    Россия будет следить за встречей стран по мирному урегулированию на Украине, которую, по данным The Wall Street Journal, хотят провести власти Саудовской Аравии. Об этом заявил пресс-секретарь российского президента Дмитрий Песков. 
  ', 1690796306, 'https://lenta.ru/news/2023/07/31/norussia/', -8867160390595920559);
INSERT INTO public."NewsRss" VALUES (79389, 'Песков указал на неэффективное расходование средств Киевом', '
    Украина вызвала дискомфорт у Запада неэффективным расходованием помощи, на это указал пресс-секретарь президента России Дмитрий Песков. 
  ', 1690796267, 'https://lenta.ru/news/2023/07/31/diskomf/', 2858969720912929831);
INSERT INTO public."NewsRss" VALUES (79691, 'Перечислены способы защиты Крымского моста от атак', '
    Военный эксперт Василий Дандыкин заявил, что установить  боновые заграждения на всей протяженности Крымского моста будет крайне непросто. Ввиду этого вероятно использование альтернативных способов его защиты, таких как усиление противодиверсионной службы и контроль надводной обстановки.
  ', 1690796532, 'https://lenta.ru/news/2023/07/31/zsht/', 2043535414252336900);
INSERT INTO public."NewsRss" VALUES (79696, 'Песков предсказал ухудшение безопасности в Европе из-за политики США', '
    Официальный представитель Кремля Дмитрий Песков заявил, что политика США противоречит международным нормам и будет вести к дальнейшему ухудшению безопасности в Европе.
  ', 1690796522, 'https://lenta.ru/news/2023/07/31/predskazaniye/', 6568718384921322457);
INSERT INTO public."NewsRss" VALUES (79701, 'Шойгу доложил Путину об итогах своего визита в Северную Корею', '
    Министр обороны Сергей Шойгу уже доложил президенту России Владимиру Путину об итогах своего недавнего визита в Северную Корею и встречи с лидером этой страны Ким Чен Ыном.
  ', 1690796494, 'https://lenta.ru/news/2023/07/31/itogi/', 6248152725433721079);
INSERT INTO public."NewsRss" VALUES (80008, 'Уничтожение танков Challenger 2 вместо передачи их Украине объяснили', '
    По косвенным признакам перед Вооруженными силам Украины (ВСУ) поставлена задача минимизировать потери западной техники, рассказал кандидат политических наук, доцент кафедры политического анализа факультета государственного управления МГУ имени Ломоносова Александр Коньков в разговоре с «Лентой.ру».
  ', 1690796694, 'https://lenta.ru/news/2023/07/31/oruzie_kiev/', -3471917331032300459);
INSERT INTO public."NewsRss" VALUES (80013, 'Звезду «Обустройства дома» Брайана арестовали по обвинению в домашнем насилии', '
    Актер, наиболее известный ролью Брэда Тейлора в сериале «Обустройство дома», Закари Ти Брайан снова арестован по обвинению в домашнем насилии. Сообщается, что артист был задержан и обвинен в нарушении закона о предотвращении насилия, меры, которая применяется к преступникам, уже совершавшим подобное.
  ', 1690796648, 'https://lenta.ru/news/2023/07/31/zachery_vina/', 3814881036897140635);
INSERT INTO public."NewsRss" VALUES (80385, '«Фиорентина» заменит дисквалифицированный «Ювентус» в Лиге конференций', '
    «Фиорентина» заменит «Ювентус» в Лиге конференций. В сезоне-2022/2023 «Фиорентина» дошла до финала Лиги конференций, где уступила «Вест Хэму» со счетом 1:2. В чемпионате Италии команда заняла восьмое место. УЕФА отстранил «Ювентус» на один год от еврокубков из-за нарушения финансового фейр-плей.
  ', 1690797470, 'https://lenta.ru/news/2023/07/31/fiorentina/', -5864551600630329671);
INSERT INTO public."NewsRss" VALUES (80330, 'В Go 1.21 существенно расширяется стандартная библиотека', '// теперь в Go так можно!
slices.Contains(s, v)
Год назад в блоге Каруны мы писали про дженерики в Go, и там упоминалось, что гошное сообщество разделилось на две части. Не всем это нововведение было нужно, особенно в простом продуктовом коде. И надо сказать, это до сих пор так, дженерики по-прежнему используют далеко не все проекты.
Однако для стандартной библиотеки Go это было по-настоящему царским подарком. Появились новые стандартные обобщенные функции, и, отстоявшись в экспериментальном репозитории golang.org/x/exp, теперь появятся в Go 1.21. Релиз буквально через месяц.
TLDR: появилось множество функций по работе со слайсами, мапами, а также новый логгер с (почти) всеми нужными фишечками.
Лично для меня знаковым событием стало появление возможности поиска элемента в слайсе и получение ключей мапы, потому что ну давно пора, 10 лет языку.
Но давайте обо всём по порядку. Читать дальше &rarr;', 1690797063, 'https://habr.com/ru/companies/karuna/articles/747726/?utm_campaign=747726&utm_source=habrahabr&utm_medium=rss', -7778215553491547900);
INSERT INTO public."NewsRss" VALUES (80339, 'Шойгу рассказал об увеличении ударов российской армии по украинским объектам', '
    Российская армия в разы увеличила интенсивность ударов по украинским военным объектам. Об этом рассказал глава Минобороны страны Сергей Шойгу.
  ', 1690798079, 'https://lenta.ru/news/2023/07/31/shoiguss/', -8808775341799773019);
INSERT INTO public."NewsRss" VALUES (80344, 'Шойгу сообщил об освобождении трех населенных пунктов на одном из направлений', '
    На краснолиманском направлении российские войска освободили Ковалевку, Сергеевку и Молчановку, сообщил министр обороны России Сергей Шойгу.
  ', 1690798057, 'https://lenta.ru/news/2023/07/31/new_vins/', 498176207428606511);
INSERT INTO public."NewsRss" VALUES (80348, 'Шойгу объяснил совершение Киевом террористических атак', '
    Киев совершает террористические атаки из-за провала контрнаступления. Так министр обороны Сергей Шойгу объяснил украинские удары беспилотниками и ракетами по территории России. По словам главы российского Министерства обороны, подобные атаки совершаются Украиной при поддержке западных спонсоров.
  ', 1690797960, 'https://lenta.ru/news/2023/07/31/proval/', -3663563400103826800);
INSERT INTO public."NewsRss" VALUES (80353, 'Названы регионы России с самым доступным бензином', '
    Лидерами по доступности бизнеса в России в первом полугодии 2023 года стали Ямало-Ненецкий автономный округ, Москва и Чукотка. Жители этих регионов на среднемесячную зарплату могут позволить себе купить две тысячи литров бензина марки Аи-92. В среднем по России этот показатель составляет 1196 литров в месяц.
  ', 1690797922, 'https://lenta.ru/news/2023/07/31/benzin/', -3662827325380140304);
INSERT INTO public."NewsRss" VALUES (80358, 'Шойгу заявил о потере Украиной более 20 тысяч военнослужащих за месяц', '
    Вооруженные силы Украины (ВСУ) за прошедший месяц потеряли более 20 тысяч человек. Об этом сообщил глава Минобороны России Сергей Шойгу, его цитирует ТАСС.
  ', 1690797916, 'https://lenta.ru/news/2023/07/31/shoigu/', -3657101233381603264);
INSERT INTO public."NewsRss" VALUES (80364, 'Хирург Успенской раскрыл подробности об осложнениях после пластики у Хайдарова', '
    Хирург певицы Любови Успенской Артур Рыбакин раскрыл подробности об осложнениях после пластики у Тимура Хайдарова. Звезда обратилась к нему с жалобами на боли в груди и асимметрию имплантов. В связи с этим медик провел повторное вмешательство, в ходе которого были обнаружены лишние фрагменты рубцовой ткани.
  ', 1690797906, 'https://lenta.ru/news/2023/07/31/plastikausp/', 6748827505295617796);
INSERT INTO public."NewsRss" VALUES (80369, 'Путин подписал закон о налогах для уехавших россиян', '
    Президент России Владимир Путин подписал закон, вводящий единую ставку НДФЛ для сотрудников, работающих удаленно на российские компании как в России, так и за рубежом. Она составит 13-15 процентов.
  ', 1690797780, 'https://lenta.ru/news/2023/07/31/nalog/', 6250372097234284791);
INSERT INTO public."NewsRss" VALUES (80374, 'ВКС России получили модернизированные перехватчики МиГ-31', '
    Объединенная авиастроительная корпорация (ОАК, входит в госкорпорацию «Ростех») передала Минобороны России партию модернизированных высотных истребителей-перехватчиков МиГ-31, которые получили расширенные возможности, сообщили в пресс-службе корпорации. Самолеты модернизировали на заводе «Сокол».
  ', 1690797530, 'https://lenta.ru/news/2023/07/31/mig31/', 6255240402575253751);
INSERT INTO public."NewsRss" VALUES (80379, 'В Запорожской области рассказали о колоссальных потерях ВСУ', '
    Врио главы Запорожской области Евгений Балицкий рассказал, что Вооруженные силы Украины (ВСУ) терпят колоссальные потери на запорожском направлении.
  ', 1690797480, 'https://lenta.ru/news/2023/07/31/balitskii/', 2153952109180231150);
INSERT INTO public."NewsRss" VALUES (80391, 'Российский полковник указал на шаг Киева к мирным переговорам', '
    Планируемые переговоры Украины и США относительно гарантий безопасности, вероятно, могут стать шагом на пути к мирному урегулированию российско-украинского конфликта. О первых признаках подготовки Киевом и Вашингтоном фундамента для переговоров о мире рассказал военный эксперт, полковник в отставке Анатолий Матвийчук.
  ', 1690797392, 'https://lenta.ru/news/2023/07/31/peace_talks/', -4829429857574889538);
INSERT INTO public."NewsRss" VALUES (80399, 'В России рекордно подорожала курятина', '
    По итогам июня 2023 года стоимость килограмма охлажденного и мороженого мяса кур увеличилась на 6,8 процента и составила рекордные 193,48 рубля. При этом независимые аналитики говорят о еще большем росте — до 270 рублей. Главные причины — увеличение цен на компоненты кормовых добавок и производственное оборудование.
  ', 1690797359, 'https://lenta.ru/news/2023/07/31/chicken_russia/', -4687776661106688931);
INSERT INTO public."NewsRss" VALUES (80405, 'Бывший мэр российского города пойдет под суд за 17-миллионный ущерб бюджету', '
    Следователи Приморского края передали в суд дело бывшего мэра Владивостока Олега Гуменюка, который уже осужден за взятки. Он обвиняется в превышении должностных полномочий при ремонте катера администрации края в 2017 году. Тогда он возглавлял хозяйственное управление и нанес ущерб бюджету.
  ', 1690797236, 'https://lenta.ru/news/2023/07/31/oleggomenyuk/', -5802555190259072438);
INSERT INTO public."NewsRss" VALUES (80411, 'В Британии предрекли трудности Украине из-за выборов в США', '
    Обозреватель британского издания Telegraph Ричард Кемп заявил, что для президента США Джо Байдена участие в конфликте на стороне Украины перестанет быть выгодным из-за президентских выборов. «Байден будет искренне желать того, чтобы конфликт завершился до избирательного сезона», — заявил журналист. 
  ', 1690797060, 'https://lenta.ru/news/2023/07/31/vybory_problema/', 645268823847405977);
INSERT INTO public."NewsRss" VALUES (80416, 'Кремль высказался о ситуации в Нигере', '
    Москва выступает за восстановление законности в Нигере. Так о ситуации в африканской стране высказался представитель Кремля Дмитрий Песков. «Мы выступаем за скорейшее восстановление законности в стране, мы выступаем за сдержанность всех сторон», — заявил пресс-секретарь российского лидера.
  ', 1690797060, 'https://lenta.ru/news/2023/07/31/zakon/', 6247047156624290039);
INSERT INTO public."NewsRss" VALUES (80420, 'Названо отношение россиян к естественной красоте', '
    Аналитики сервиса «Авито.Услуги» назвали отношение россиян к натуральной красоте. Согласно исследованию, 66 процентов опрошенных заявили, что естественная внешность остается вечно модной. Так, они указали, что считают излишними макияж, наращивание волос и ресниц и увеличение губ.
  ', 1690797000, 'https://lenta.ru/news/2023/07/31/naturalbeauty/', -3847239075517951149);
INSERT INTO public."NewsRss" VALUES (80423, 'Рост цен на российскую нефть перестал поддерживать рубль', '
    За последние пять недель цена основного экспортного сорта российской нефти Urals выросла почти на 30 процентов и приблизилась к 70 долларам за баррель, однако на стоимость рубля такая динамика никакого влияния не оказала. Российская валюта не растет из-за роста импорта, оттока капитала и дефицита бюджета.
  ', 1690796760, 'https://lenta.ru/news/2023/07/31/rublneft/', 2126258762812134980);
INSERT INTO public."NewsRss" VALUES (80656, 'Шойгу заявил о принятии дополнительных мер защиты после терактов Украины', '
    После организации Украиной терактов на территории России приняты дополнительные меры для защиты объектов. Об этом на селекторном совещании с руководящим составом Вооруженных сил России сообщил министр обороны Сергей Шойгу, его цитирует ТАСС.
  ', 1690798221, 'https://lenta.ru/news/2023/07/31/shoigumeri/', -2769669591685702195);
INSERT INTO public."NewsRss" VALUES (80661, 'Шойгу заявил о срыве масштабной попытки ВСУ прорвать российскую оборону', '
    Российские военнослужащие на ореховском направлении сорвали масштабную попытку Вооруженных сил Украины (ВСУ) прорвать оборону. Об этом заявил глава Минобороны Сергей Шойгу.
  ', 1690798140, 'https://lenta.ru/news/2023/07/31/popitka/', -7806694854930583142);
INSERT INTO public."NewsRss" VALUES (81618, 'Дачников призвали закапывать в землю кожуру от бананов', '
    Владельцев дачных участков призвали закапывать в землю кожуру от банана для подкормки растений. Такой совет им дала агроном и ландшафтный дизайнер Анастасия Коврижных. Эксперт отметила, что данная подкормка служит универсальным средством, но лучше всего на нее реагируют цитрусовые, картофель, томаты, огурцы.
  ', 1690798738, 'https://lenta.ru/news/2023/07/31/banan/', 6247038509511799031);
INSERT INTO public."NewsRss" VALUES (81623, 'Зеленский подписал закон о запрете полетов беспилотников над границей', '
    Президент Украины Владимир Зеленский подписал закон, запрещающий использование беспилотных летательных аппаратов (БПЛА) над приграничной зоной и разрешающий Службе безопасности Украины (СБУ) сбивать их. Об этом сообщил в Telegram депутат Верховной Рады Ярослав Железняк.
  ', 1690798716, 'https://lenta.ru/news/2023/07/31/zezakon/', 1270185203548086132);
INSERT INTO public."NewsRss" VALUES (81942, 'На Украине рассказали о готовности боевиков «Азова» вернуться на фронт', '
    Вернувшиеся на Украину боевики бригады «Азов» (запрещенная в России террористическая организация) могут вернуться на фронт в ближайшие дни. Об их готовности сообщил командующий Нацгвардией Украины Александр Пивненко. По его словам, обменянные боевики «Азова» сейчас проходят подготовку.
  ', 1690799088, 'https://lenta.ru/news/2023/07/31/azov/', 2044489911068849924);
INSERT INTO public."NewsRss" VALUES (81947, 'Человек загорелся после взрыва в ресторане в центре Москвы', '
    Человек загорелся после взрыва в ресторане «Пироги, вино и гусь» в Тверском районе в центре Москвы. Об этом сообщил источник Telegram-каналу Shot. К месту происшествия выехали представители столичных экстренных служб. 
  ', 1690798920, 'https://lenta.ru/news/2023/07/31/gusssd/', -3664258735440370304);
INSERT INTO public."NewsRss" VALUES (82016, '[Перевод - recovery mode ] Самый быстрый и безопасный PNG декодер в мире', 'Декодер изображений PNG из стандартной библиотеки языка программирования Wuffs работает в 1.22–2.75 раза быстрее, чем libpng (широко используемая реализация PNG декодера на C с открытым исходным кодом), C-библиотеки libspng, lodepng и stb_image, а также самые популярные библиотеки для работы с PNG на Go и Rust.Статья рассказывает о том, как именно достигается такая производительность. Читать далее', 1690796496, 'https://habr.com/ru/articles/751462/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751462', -1039160487145144412);
INSERT INTO public."NewsRss" VALUES (82263, 'Козел из Дагестана зацепился рогами за провода и превратил их в качели', '
    В Дагестане козел попытался выпрыгнуть из грузовика, на котором перевозили часть стада, и зацепился рогами за провода. Видео, на котором животное раскачивается на проводах, как на качелях, попало в сеть. Животное в итоге удалось снять с проводов и вернуть к сородичам для дальнейшей транспортировки. 
  ', 1690799160, 'https://lenta.ru/news/2023/07/31/swinging_goat/', -7302256147210707680);
INSERT INTO public."NewsRss" VALUES (82349, 'Как генерировать модели интерфейсов на основе спецификации на стороне frontend-приложений', 'На связи снова Архитектурный комитет компании SimbirSoft, и мы продолжаем наш цикл статей, посвященных Design API First. Ранее мы уже писали о том, что представляет собой этот подход, приводили пример спецификации для сервиса аутентификации и рассказывали, как мы интегрируем этот паттерн в наш конвейер разработки.Сегодня мы немного отвлечемся от бэкенда и разберем автоматизацию одной из рутинных задач на стороне frontend-разработки. А именно описание моделей интерфейсов для взаимодействия фронта с беком, а также написание API-сервисов, в которых фиксируются endpoints, методы запросов и формат передачи данных (query-параметры, заголовки, тело). Читать далее', 1690797083, 'https://habr.com/ru/companies/simbirsoft/articles/751406/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751406', -3526442124676858336);
INSERT INTO public."NewsRss" VALUES (82587, 'Грузины закидали яйцами россиян с круизного лайнера и попали на видео', '
    Грузинские оппозиционеры закидали яйцами россиян с круизного лайнера Astoria Grande и попали на видео. На размещенных кадрах видны выезжающие из порта Батуми микроавтобусы с пассажирами лайнера, в которые летят пустые пластиковые бутылки и яйца. Сообщается, что полиция задержала девять участников акции протеста.
  ', 1690799469, 'https://lenta.ru/news/2023/07/31/eggs/', 2042383719618115332);
INSERT INTO public."NewsRss" VALUES (82592, 'Сообщения о вспышке холеры в российском регионе не подтвердились', '
    В соцсетях распространились сообщения о том, что в Шацком районе Рязанской области якобы произошла вспышка холеры. Впоследствии данные сведения не подтвердились. Глава администрации района Александр Нечушкин сообщил, что вспышки холеры на территории муниципального образования не зарегистрировано.
  ', 1690799425, 'https://lenta.ru/news/2023/07/31/ryaz/', 2041314389582214916);
INSERT INTO public."NewsRss" VALUES (82597, 'Стало известно о возможном задержании украинки на протесте в Грузии', '
    Министерство иностранных дел (МИД) Украины проверяет информацию о задержании украинки во время протеста из-за прибытия круизного лайнера с россиянами в грузинский порт Батуми. Об этом заявил пресс-секретарь украинского МИД Олег Николенко. По его словам, дипломаты видели сообщения об этом и проверяют их.
  ', 1690799376, 'https://lenta.ru/news/2023/07/31/zaderj/', -3662040339617041296);
INSERT INTO public."NewsRss" VALUES (82602, 'Стало известно об ухудшении состояния Ирины Мирошниченко', '
    Стало известно об ухудшении состояния народной артистки России Ирины Мирошниченко, которую ранее госпитализировали с тяжелой формой гриппа. Сообщается, что актрису подключили к аппарату ИВЛ, а также диагностировали тяжелое поражение клапана сердца. Динамика состояния Мирошниченко — отрицательная.
  ', 1690799301, 'https://lenta.ru/news/2023/07/31/irina_health/', -6273904308265401065);
INSERT INTO public."NewsRss" VALUES (82910, 'Российский полковник оценил сообщения о начале нового этапа контрнаступления ВСУ', '
    Сообщения о том, что ВСУ (Вооруженные силы Украины) начали второй этап контрнаступления являются «выдумкой» Запада, призванной оправдать отсутствие успеха украинских военных при ведении боевых действий. Об этом «Ленте.ру» сообщил военный эксперт, полковник в отставке Анатолий Матвийчук.
  ', 1690799499, 'https://lenta.ru/news/2023/07/31/phase_deux/', 6214017444614749880);
INSERT INTO public."NewsRss" VALUES (83229, 'В Госдуме описали влияние слабого рубля на жизнь россиян', '
    Зампред комитета Госдумы по экономической политике Михаил Делягин перечислил последствия ослабления курса рубля. К ним он отнес рост цен, увеличение бедности, сжатие спроса и торможение российской экономики, на которую окажет влияние динамика цены импортного оборудования. 
  ', 1690799887, 'https://lenta.ru/news/2023/07/31/delyagin/', 1034161635435409023);
INSERT INTO public."NewsRss" VALUES (84197, 'Стали известны подробности о похитившем на 14 лет девушку россиянине', '
    Мужчина, который на протяжении 14 лет насильно удерживал похищенную женщину в поселке Смолино Челябинской области, вел скрытный образ жизни. Об этом в беседе с «Лентой.ру» рассказала местная жительница, пожелавшая остаться анонимной. По словам челябинки, мужчина проживал с матерью и много пил.  
  ', 1690800422, 'https://lenta.ru/news/2023/07/31/skritnost/', 2540752436555161085);
INSERT INTO public."NewsRss" VALUES (84200, 'На Украине подростка осудили за исполнение песни Цоя', '
    На Украине суд признал виновным в хулиганстве 17-летнего молодого человека, исполнившего песню Виктора Цоя на улице во Львове. В качестве наказания суд ограничился предупреждением, сообщила депутат Верховной Рады Наталья Пипа. Именно с ней у парня был конфликт из-за исполнения песни.
  ', 1690800347, 'https://lenta.ru/news/2023/07/31/tsoy/', 2042079729708758788);
INSERT INTO public."NewsRss" VALUES (84205, 'Звезда фильма «Она — мужчина» вновь легла в психиатрическую клинику', '
    Американская актриса и звезда фильма «Она — мужчина» Аманда Байнс легла в психиатрическую клинику спустя неделю после выписки из аналогичного учреждения. На этот раз артистка записалась в клинику в округе Ориндж, где будет круглосуточно находиться под наблюдением врачей, а также общаться с другими пациентами.
  ', 1690800318, 'https://lenta.ru/news/2023/07/31/amanda_mental/', 7319584865280649708);
INSERT INTO public."NewsRss" VALUES (84211, 'Галустян рассказал об особенном отношении к нему Маслякова', '
    Комик, актер и телеведущий Михаил Галустян рассказал об особенном отношении к нему руководителя КВН Александра Маслякова. Галустян начал участвовать в КВН во время обучения в школе. Позднее вступил в команду «Утомленные солнцем», образованную на базе Сочинского государственного университета туризма и курортного дела.
  ', 1690800306, 'https://lenta.ru/news/2023/07/31/galst_masl/', 6364472327415505928);
INSERT INTO public."NewsRss" VALUES (84216, 'Анна Седокова показала лицо без косметики', '
    Певица Анна Седокова показала внешность без косметики по пути в больницу. На размещенном снимке бывшая солистка группы «ВИА Гра» позировала на заднем сиденье машины в черном наряде. 40-летняя исполнительница надела пиджак и топ и дополнила образ бейсболкой. Также звезда показала видео, где ходила на костылях.
  ', 1690800271, 'https://lenta.ru/news/2023/07/31/annawithoutmakeup/', -8010213667958093032);
INSERT INTO public."NewsRss" VALUES (84221, 'ВМФ России получит три «Каракурта» до конца года', '
    В 2023 года в состав Военно-морского флота России планируют принять три малых ракетных корабля проекта 22800 «Каракурт», которые является носителями ракет семейства «Калибр-НК», сообщил министр обороны России Сергей Шойгу. В 2024 году планируют ввести в эксплуатацию еще два корабля этого проекта.
  ', 1690800194, 'https://lenta.ru/news/2023/07/31/22800/', 6255120206436626679);
INSERT INTO public."NewsRss" VALUES (84227, 'Путин подписал закон о внеплановом повышении акцизов на сигареты и алкоголь', '
    Президент России Владимир Путин подписал закон, согласно которому акцизные ставки на алкоголь, табачную продукцию, автомобили и бензин повышаются на 5 процентов в 2024 году. Изначально планировалось, что рост ставки в этом году составит четыре процента. Причем в 2025 и 2026 годах индексация снова составит 4 процента.
  ', 1690800154, 'https://lenta.ru/news/2023/07/31/akciz_alko/', -2978490376712115139);
INSERT INTO public."NewsRss" VALUES (84230, 'Сын Лукашенко получил президентскую стипендию', '
    Сын президента Белоруссии Александра Лукашенко Николай получил ежемесячную президентскую стипендию. Студента первого курса Белорусского государственного университета с именем Николай Александрович Лукашенко обнаружили в документе, подписанном главой государства. Размер стипендии составляет 186,97 белорусских рублей.
  ', 1690800120, 'https://lenta.ru/news/2023/07/31/synlukashenko/', 6566717561263149289);
INSERT INTO public."NewsRss" VALUES (84574, '«Скайнет в эпоху киберпанка. Теория сверхразума и вызовы перед человечеством в XXI веке»: Обзор книги', 'На портале «Литрес» вышла книга, написанная двумя людьми и одним ИИ. Поскольку сейчас нейросети и чат-боты на волне популярности или, как принято говорить, «на хайпе», то и к новостям, связанным с ИИ, приковано внимание.Вообще концепция нейросетей была разработана давно. Взять тот же перцептрон. Однако эти новости у обывателя были больше связаны с выигрышами ИИ у человека в различные интеллектуальные игры. Начиная с 2020 года, проявилось повальное использование нейросетей в так называемых «творческих» профессиях. Музыка, рисунки, тексты — все это начали генерировать ИИ в огромных количествах. А с развитием моделей GPT и основанного на них чат-бота ChatGPT начались и более сложные задачи — сдача экзаменов, написание программного кода.Естественно, это не обошло стороной литературу. Про простые тексты уже было сказано, настал черед книг — сначала детских, а далее и произведений других жанров. И вот в РФ решили присоединиться ко всеобщему тренду, в связи с чем на портале «Литрес» была издана первая книга, написанная в соавторстве с ChatGPT. Кроме чат-бота в ее создании участвовали еще два автора-человека. Читать далее', 1690794411, 'https://habr.com/ru/companies/generations/articles/751450/?utm_source=habrahabr&utm_medium=rss&utm_campaign=751450', -8713200517259887846);
INSERT INTO public."NewsRss" VALUES (84598, 'Дом державшего россиянку в плену 14 лет попал на видео', '
    Следственный комитет России обнародовал видео из дома маньяка, который удерживал в плену девушку в течение 14 лет. Частный деревянный дом находится в поселке Смолино в Челябинской области. Он огражден большим забором и украшен наличниками. По данным следствия, в этом доме проживал сам мужчина, его мать и пленница. 
  ', 1690800823, 'https://lenta.ru/news/2023/07/31/skvideoman/', -4131226977474158819);
INSERT INTO public."NewsRss" VALUES (84601, 'Стали известны детали 14-летнего плена россиянки', '
    Молодая женщина, которая провела 14 лет в плену у жителя Челябинска, выросла в детдоме. Девушка вела асоциальный образ жизни, а когда ей было 19 лет, она познакомилась со своим мучителем. Он ее угостил алкоголем, потом пригласил к себе, после чего похитил. У пленницы есть сестра, которая также жила в детдоме.
  ', 1690800540, 'https://lenta.ru/news/2023/07/31/izdetdoma/', -2857813509466220893);
INSERT INTO public."NewsRss" VALUES (84604, 'Шойгу заявил о переброске ВСУ новых сил на штурм российских позиций', '
    Командование Вооруженных сил Украины (ВСУ) бросает новые силы на штурм российских позиций. Об этом на селекторном совещании с руководящим составом Вооруженных сил России сообщил министр обороны Сергей Шойгу, его слова приводятся в Telegram-канале оборонного ведомства.
  ', 1690800480, 'https://lenta.ru/news/2023/07/31/nastup/', -3659115615451764304);
INSERT INTO public."NewsRss" VALUES (84606, 'Названа возможная причина массового отравления детей в российском лагере', '
    Массовое отравление детей в лагере «Горный орленок» в Республике Алтай могло произойти из-за грызунов. Такую возможную причину назвала сотрудница управления Роспотребнадзора по российскому региону Марина Бугреева. Об инциденте стало известно ранее. С 26 по 29 июля в лагере зафиксировали 69 случаев заражения.
  ', 1690800451, 'https://lenta.ru/news/2023/07/31/prichina/', 294845721345198352);


--
-- TOC entry 2192 (class 0 OID 0)
-- Dependencies: 196
-- Name: NewsRss_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."NewsRss_id_seq"', 85143, true);


--
-- TOC entry 2054 (class 2606 OID 333913076)
-- Name: NewsRss NewsRss_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NewsRss"
    ADD CONSTRAINT "NewsRss_pk" PRIMARY KEY (id);


--
-- TOC entry 2052 (class 1259 OID 333913077)
-- Name: NewsRss_hashrss_IDX; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "NewsRss_hashrss_IDX" ON public."NewsRss" USING btree (hashrss);


-- Completed on 2023-07-31 18:00:52

--
-- PostgreSQL database dump complete
--

