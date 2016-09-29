sqlite> SELECT Customer.cust_name, Sale.Sale_quantity
   ...> FROM Customer
   ...> INNER JOIN Sale
   ...> ON Customer.cust_id=Sale.cust_id
   ...> ORDER BY Sale.sale_quantity;
Billy Richards|48
Louise Cox|139
Jennifer Sanders|220
Doris Wood|275
Deborah Richards|416
Diane Snyder|458
Alice Jackson|507
Russell Kelley|686
Johnny Richards|821
Tammy Grant|824
Frances Cox|947
Angela Cruz|962
Phillip Long|1021
Wanda Wallace|1125
Johnny Richards|1491
Janet Wood|1571
Eugene Parker|1599
Earl Little|1689
Frances Cox|1707
Roy Wheeler|1936
Deborah Richards|1960
Denise Nelson|2042
Charles Wallace|2055
Marie Rivera|2274
Angela Cruz|2413
Phillip Long|2441
Nicole Ward|2449
Denise Nelson|2611
Earl Little|2645
Phillip Long|2657
Margaret Simmons|2721
Peter Holmes|3225
Deborah Simpson|3278
Marie Rogers|3282
Fred Johnston|3292
Russell Kelley|3562
Paula Sims|3640
Thomas Ray|3676
Roy Wheeler|3686
Jennifer Sanders|3760
Cheryl Moreno|3791
Theresa Oliver|3990
Alice Jackson|4122
Gerald Moore|4349
Jennifer Sanders|4439
Kevin Cox|4455
Angela Cruz|4643
Willie Grant|4897
Diane Snyder|4910


sqlite> select Customer.cust_name, sum(Invoice.invoice_balance) as total
   ...> from Customer, Sale, Invoice
   ...> where Customer.cust_id = Sale.cust_id
   ...> and Sale.invoice_id = Invoice.invoice_id
   ...> group by Customer.cust_id
   ...> order by total;
Fred Johnston|33.73
Peter Holmes|34.2
Marie Rogers|53.2
Willie Grant|57.1
Charles Wallace|68.5
Kevin Cox|68.5
Diane Snyder|77.04
Johnny Richards|77.73
Billy Richards|85.94
Margaret Simmons|100.17
Tammy Grant|100.17
Deborah Simpson|105.08
Janet Wood|105.08
Marie Rivera|105.47
Nicole Ward|111.62
Thomas Ray|113.81
Earl Little|114.2
Cheryl Moreno|119.31
Wanda Wallace|122.11
Paula Sims|128.89
Frances Cox|133.06
Denise Nelson|158.18
Doris Wood|168.56
Russell Kelley|173.97
Roy Wheeler|177.47
Deborah Richards|181.73
Louise Cox|188.1
Angela Cruz|191.0
Gerald Moore|195.07
Theresa Oliver|195.07
Eugene Parker|199.88
Alice Jackson|231.97
Phillip Long|259.654
Jennifer Sanders|477.71


sqlite> select Supplier.supplier_name, sum(Invoice.invoice_balance) as total
   ...> from Supplier, Purchase, Invoice
   ...> where Supplier.supplier_id = Purchase.supplier_id
   ...> and Purchase.invoice_id = Invoice.invoice_id
   ...> group by Supplier.supplier_id
   ...> order by total;
Twitterbridge|14.27
Wordify|14.27
Youbridge|33.73
Teklist|34.2
Blognation|34.2
Bubbletube|39.33
Aibox|39.33
Skipstorm|53.2
Realblab|57.04
Jabberstorm|76.65
Tazz|84.2
Photobug|85.94
Zoombox|88.32
Midel|92.42
Rhycero|97.17
Kazio|105.47
Zooxo|106.52
Oozz|114.01
Agimba|119.31
Rhybox|120.48
Skinder|120.48
Trudoo|143.09
Thoughtbridge|159.55
Yodo|168.56
Shufflester|195.07
Meejo|197.45
Eimbee|199.88
LiveZ|201.27
Miboo|234.81
Skimia|254.28
Skinte|293.32
Eimbee|487.28

sqlite> SELECT Customer.cust_name, sum(Sale.Sale_quantity) as quantity
   ...> FROM Customer
   ...> INNER JOIN Sale
   ...> ON Customer.cust_id=Sale.cust_id
   ...> GROUP BY Customer.cust_id
   ...> ORDER BY quantity;
Billy Richards|48
Louise Cox|139
Doris Wood|275
Tammy Grant|824
Wanda Wallace|1125
Janet Wood|1571
Eugene Parker|1599
Charles Wallace|2055
Marie Rivera|2274
Johnny Richards|2312
Deborah Richards|2376
Nicole Ward|2449
Frances Cox|2654
Margaret Simmons|2721
Peter Holmes|3225
Deborah Simpson|3278
Marie Rogers|3282
Fred Johnston|3292
Paula Sims|3640
Thomas Ray|3676
Cheryl Moreno|3791
Theresa Oliver|3990
Russell Kelley|4248
Earl Little|4334
Gerald Moore|4349
Kevin Cox|4455
Alice Jackson|4629
Denise Nelson|4653
Willie Grant|4897
Diane Snyder|5368
Roy Wheeler|5622
Phillip Long|6119
Angela Cruz|8018
Jennifer Sanders|8419


sqlite> SELECT Product.prod_name, sum(Sale.Sale_quantity) as quantity
   ...> FROM Product, Sale
   ...> where Product.prod_id = Sale.prod_id
   ...> GROUP BY Product.prod_id
   ...> order by quantity;
acrylic paint|416
sponge�|824
Mod Podge|947
burlap|1125
air dry clay|1469
pom poms�|1491
wood beads�|1707
craft foam|1936
brads�|2103
craft felt|2449
yarn�|2611
wood shapes|2657
chenille stems|2721
brayer|3282
glitter�|3417
liquid starch�|3562
printing ink|3640
fishing line|3791
glass beads�|3869
painters tape�|3978
craft/popsicle sticks|3990
white glue|4439
straws�|4796
pony beads�|4854
toothpicks�|4897
clay|4910
ink pad�|5143
feathers�|5194
floral wire|5922
thread|7362
watercolors|7401
fabric glue|8804


sqlite> SELECT Product.prod_name, Product.prod_qoh as qoh
   ...> FROM Product
   ...> where qoh > 150
   ...> order by qoh;
tempera paint|152
egg cartons|152
newspaper|153
cardboard|155
old sheet(s)|155
Mod Podge|159
thread|160
bubble wrap|160
roll of white paper (i.e. butcher paper, wrapping paper)|161
sponge|163
glitter|165
fabric glue|166
tag board/card stock|167
leaves|167
glass beads|171
string|173
seeds & seed pods|173
colored tissue paper|174
homemade dough|176
clean cans & jars|178
clay|179
wood beads|181
rubber stamps|181
acrylic paint|182
googly eyes|185
liquid starch|189
milk cartons|189
fabric scraps|193
junk mail|193
magazines|195
muslin|196
acorns|196

SELECT Product.prod_name, sum(Sale.Sale_quantity) as quantity
FROM Product, Sale
where Product.prod_id = Sale.prod_id
GROUP BY Product.prod_id
order by quantity;

sqlite> SELECT Product.prod_name, Product.prod_qoh as qoh
   ...> FROM Product
   ...> where qoh <=5
   ...> order by qoh;
crepe paper|0
craft felt|3
painters tape|4
plastic lids|4
scissors|5


SELECT Product.prod_name, Product.prod_qoh as qoh
FROM Product
where qoh <=5
order by qoh;


select Supplier.supplier_name, sum(Invoice.invoice_balance) as total
from Supplier, Purchase, Invoice
where Supplier.supplier_id = Purchase.supplier_id
and Purchase.invoice_id = Invoice.invoice_id
group by Supplier.supplier_id
order by total;