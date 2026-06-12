# UrbanCart SQL Data Analysis

## Project Overview

UrbanCart is a fictional Bangladesh-based e-commerce retailer selling groceries, electronics, fashion, and household products. This project analyzes UrbanCart's transactional data — customers, orders, order items, products, and payments — to uncover insights about sales performance, customer behavior, product trends, payment patterns, and operational reporting.

**Objectives:**
- Understand overall sales performance and revenue drivers
- Identify high-value customers, products, and locations
- Analyze customer demographics and purchasing behavior
- Examine payment method trends and their relationship with order outcomes
- Detect inventory risks and product bundling opportunities
- Provide a daily operational reporting view

All analysis was performed using **PostgreSQL**. SQL scripts for every question are organized in separate `.sql` files in this repository (see [SQL Files](#sql-files) section below). No SQL code is included in this README — only results, insights, and recommendations.

---

## Database Schema / ER Diagram

The data is structured as a star schema with two dimension tables and three fact tables.
## Database Schema

![ER Diagram](er_diagram.png)
| Table | Description | Rows |
|---|---|---|
| `dimcustomers` | Customer details (name, gender, email, phone, city, signup date) | 100 |
| `dimproducts` | Product catalog (name, category, unit price, stock) | 41 |
| `factorders` | Order-level data (customer, order date, status) | 1,200 |
| `factorderitems` | Line items per order (product, quantity) | 4,800 |
| `factpayment` | Payment method per order | 1,200 |

![ER Diagram](images/schema_diagram.png)

<img width="745" height="382" alt="Screenshot 2026-06-12 192623" src="https://github.com/user-attachments/assets/81de9bd8-a351-4c68-9db5-a89190910c5d" />





---

## SQL Files

| File | Covers |
|---|---|
| `SALES ANALYSIS.sql` | Q1, Q2, Q4, Q6, Q7, Q8, Q9, Q25 |
| `CUSTOMER ANALYSIS.sql` | Q3, Q11, Q13, Q14, Q15, Q16 |
| `PAYMENT ANALYSIS.sql` | Q17, Q18, Q19, Q20, Q21 |
| `PRODUCT ANALYSIS.sql` | Q22, Q23, Q24 |
| `INVENTORY ANALYSIS.sql` | Q10 |
| (Cancellation queries) | Q12 |

---

## Business Questions, Results & Insights

### Q1. How many total orders has UrbanCart received so far?

**Result:**

| Total Orders |
|---|
| 1,200 |

**Insight:** UrbanCart has processed a total of 1,200 orders, reflecting a solid and active customer base over the recorded period.

---

### Q2. Which cities generate the highest number of orders & revenue?

**Result:**

| City | Total Orders | Total Revenue |
|---|---|---|
| Barishal | 173 | 318,460 |
| Sylhet | 148 | 266,438 |
| Chattogram | 140 | 257,878 |
| Rajshahi | 126 | 253,313 |
| Cumilla | 126 | 249,367 |
| Rangpur | 121 | 230,406 |
| Khulna | 121 | 225,483 |
| Gazipur | 103 | 196,189 |
| Dhaka | 81 | 128,683 |
| Narayanganj | 61 | 118,905 |

**Insight:** Barishal leads in both order volume (173 orders) and revenue (৳318,460), making it UrbanCart's strongest market — followed closely by Sylhet and Chattogram. Interestingly, Dhaka — often assumed to be the largest market — ranks lower (9th), suggesting UrbanCart's customer base is more spread across regional cities than concentrated in the capital.

---

### Q3. What percent of total customers use Gmail?

**Result:**

| Gmail Users | Total Customers | Gmail Percentage |
|---|---|---|
| 76 | 100 | 76.00% |

**Insight:** 76% of UrbanCart's customers use Gmail addresses, making it by far the dominant email provider among the customer base. This suggests email marketing campaigns should be optimized for Gmail (e.g., considering Gmail's promotions tab behavior, image rendering, etc.).

---

### Q4. What is the monthly trend of total orders over time?

**Result:**

| Year | Month | Total Orders |
|---|---|---|
| 2025 | September | 243 |
| 2025 | October | 413 |
| 2025 | November | 371 |
| 2025 | December | 173 |

**Insight:** Orders peaked in October 2025 (413 orders), nearly doubling September's volume, then gradually declined through November and dropped sharply in December (173 orders) — possibly indicating a strong seasonal sales period (e.g., a festival or promotional campaign) in October followed by a post-peak slowdown.

---
### Q5. What is the Completed, Pending & Cancelled Rate?

**Result:**

| Status | Order Count | Percentage |
|---|---|---|
| Completed | 713 | 59.42% |
| Cancelled | 246 | 20.50% |
| Pending | 241 | 20.08% |

**Insight:** Nearly 60% of UrbanCart's orders are successfully completed, but a combined 40.58% remain either Cancelled or Pending — an unusually high share. The cancellation rate (20.50%) is particularly notable and aligns with earlier findings (Q12, Q18) where COD and bKash payments showed elevated cancellation rates. Reducing this cancellation/pending share even slightly would meaningfully boost completed revenue, making order fulfillment and confirmation processes a high-priority area for operational improvement.

### Q6. What is the total revenue generated by UrbanCart?

**Result:**

| Total Revenue |
|---|
| ৳2,245,122.00 |

**Insight:** UrbanCart has generated a total revenue of ৳2,245,122 across all 1,200 orders, giving an average revenue of approximately ৳1,871 per order.

---

### Q7. Which product categories contribute the most to total revenue?

**Result:**

| Category | Total Revenue |
|---|---|
| Fashion | 513,550 |
| Grocery | 495,340 |
| Electronics | 374,250 |
| Beverages | 221,480 |
| Personal Care | 163,036 |
| Health | 134,184 |
| Digital | 106,812 |
| Meat | 61,640 |
| Snacks | 54,400 |
| Poultry | 48,640 |

**Insight:** Fashion (৳513,550) and Grocery (৳495,340) are UrbanCart's top two revenue-generating categories, together accounting for roughly 45% of total revenue. Electronics ranks third. Lower-volume categories like Snacks and Poultry contribute relatively little, suggesting either limited product range or lower customer demand in those areas.

---

### Q8. Which individual products generate the highest revenue?

**Result:**

| Product Name | Category | Total Revenue |
|---|---|---|
| Power Bank 10000mAh | Electronics | 304,000 |
| Nazirshail Rice 5kg | Grocery | 165,880 |
| Ladies Bag | Fashion | 142,200 |
| Miniket Rice 5kg | Grocery | 132,300 |
| Horlicks 500g | Health | 130,560 |
| Wallet (Men) | Fashion | 126,450 |
| Bru Coffee 200g | Beverages | 116,160 |
| T-shirt (Women) | Fashion | 105,640 |
| T-shirt (Men) | Fashion | 102,900 |
| Earphones | Electronics | 70,250 |

**Insight:** The Power Bank 10000mAh is UrbanCart's single highest revenue-generating product (৳304,000), nearly double the next best-seller. Fashion dominates the top 10 with 4 products (Ladies Bag, Wallet, two T-shirts), reinforcing Fashion's position as the top revenue category overall. Grocery items also perform consistently well, with two rice products in the top 5.

---

### Q9. What is the Average Order Value (AOV) and Average Basket Size?

**Result:**

| Average Order Value | Average Basket Size |
|---|---|
| ৳1,870.94 | 2.49 items |

**Insight:** On average, customers spend ৳1,870.94 per order and purchase about 2.5 items per order. This relatively small basket size suggests opportunities for cross-selling or bundling (e.g., "frequently bought together" promotions) to increase order value.

---

### Q10. Which products are at risk of stock-out due to high sales volume and low inventory?

**Result (sample, top 10 of more rows):**

| Product Name | Category | Stock | Total Sold |
|---|---|---|---|
| Bru Coffee 200g | Beverages | 200 | 352 |
| Power Bank 10000mAh | Electronics | 90 | 320 |
| Nazirshail Rice 5kg | Grocery | 300 | 319 |
| Clear Men Shampoo 180ml | Personal Care | 250 | 308 |
| Deshi Egg (12 pcs) | Poultry | 250 | 304 |
| Cap | Fashion | 200 | 303 |
| Shoes Polish | Personal Care | 200 | 286 |
| Wallet (Men) | Fashion | 150 | 281 |
| T-shirt (Women) | Fashion | 250 | 278 |
| Horlicks 500g | Health | 180 | 272 |

**Insight:** All of these products have already sold more units than their current stock level, meaning demand has outpaced inventory and these items are likely already out of stock or on backorder. Power Bank 10000mAh is especially critical: it's UrbanCart's #1 revenue product (Q8) but has the lowest stock (90) relative to demand (320 sold), a ratio of over 3.5x. Bru Coffee 200g shows the largest absolute gap (352 sold vs 200 stock). Immediate restocking of these top items should be a priority to avoid lost sales.

---

### Q11. Which customers contribute the highest total revenue?

**Result:**

| Customer | City | Total Revenue |
|---|---|---|
| Raisa | Sylhet | 42,516 |
| Mim | Rajshahi | 38,605 |
| Sakib | Rajshahi | 38,413 |
| Arif | Rangpur | 37,013 |
| Ehsan | Barishal | 36,092 |
| Siam | Cumilla | 35,673 |
| Towhid | Barishal | 32,653 |
| Akash | Cumilla | 32,028 |
| Shuvo | Cumilla | 31,983 |
| Shahriar | Khulna | 31,955 |

**Insight:** Raisa from Sylhet is UrbanCart's highest-spending customer (৳42,516). The top 10 customers come from a mix of cities (Sylhet, Rajshahi, Rangpur, Barishal, Cumilla, Khulna), with Cumilla and Barishal each contributing 3 of the top 10 — aligning with their strong overall city-level revenue from Q2. These customers represent strong candidates for a VIP loyalty program.

---

### Q12. Cancellation rate by city and by customer

**Result (by customer, top 10 highest cancellation rates):**

| Customer | Total Orders | Cancelled | Cancel Rate (%) |
|---|---|---|---|
| Tanvir | 12 | 6 | 50.00 |
| Masud | 13 | 6 | 46.15 |
| Sajeeb | 10 | 4 | 40.00 |
| Hasib | 8 | 3 | 37.50 |
| Keya | 14 | 5 | 35.71 |
| Shahriar | 18 | 6 | 33.33 |
| Mim | 18 | 6 | 33.33 |
| Farzana | 3 | 1 | 33.33 |
| Rakib | 37 | 12 | 32.43 |
| Jamal | 25 | 8 | 32.00 |

**Insight:** Tanvir has the highest individual cancellation rate at 50% (6 of 12 orders cancelled), followed by Masud at 46.15%. Several customers show cancellation rates above 30%, well above what would typically be considered healthy — these customers may warrant follow-up to understand recurring issues (e.g., delivery delays, payment problems, or order accuracy). On the city level (see Q19 results for payment context), cancellation patterns also vary, with COD-heavy cities showing somewhat higher cancellation counts overall.

---

### Q13. Do male and female customers show different purchasing patterns by category?

**Result (Top categories by revenue, Female vs Male):**

| Gender | Category | Orders | Total Quantity | Total Revenue |
|---|---|---|---|---|
| Female | Fashion | 231 | 574 | 216,420 |
| Female | Grocery | 493 | 1228 | 191,234 |
| Female | Electronics | 101 | 256 | 155,700 |
| Female | Beverages | 282 | 738 | 100,715 |
| Female | Personal Care | 249 | 622 | 68,250 |
| Male | Grocery | 681 | 1707 | 304,106 |
| Male | Fashion | 339 | 819 | 297,130 |
| Male | Electronics | 138 | 345 | 218,550 |
| Male | Beverages | 338 | 814 | 120,765 |
| Male | Personal Care | 338 | 852 | 94,786 |

**Insight:** Male customers generate higher revenue in every major category — most notably Grocery (৳304,106 vs ৳191,234) and Fashion (৳297,130 vs ৳216,420) — and also place significantly more orders overall (e.g., 681 vs 493 for Grocery). While female customers spend more per Fashion order on average, male customers drive higher total volume across nearly all categories. This suggests UrbanCart's male customer base is both larger and more frequent in purchasing, making them a key segment for retention efforts, while Fashion-focused promotions could help grow engagement among female customers.

---

### Q14. How does customer purchasing behavior change over time since account creation?

**Result (sample, 10 of 370 rows):**

| Customer | Account Created | Order Month | Orders | Revenue |
|---|---|---|---|---|
| Abdullah | 2025-10-12 | 2025-10 | 16 | 6,831 |
| Abdullah | 2025-10-12 | 2025-11 | 8 | 2,144 |
| Abdullah | 2025-10-12 | 2025-12 | 8 | 3,097 |
| Ayon | 2025-09-26 | 2025-09 | 4 | 592 |
| Ayon | 2025-09-26 | 2025-10 | 8 | 4,448 |
| Ayon | 2025-09-26 | 2025-11 | 24 | 7,856 |
| Taushif | 2025-09-24 | 2025-09 | 16 | 3,588 |
| Taushif | 2025-09-24 | 2025-10 | 16 | 8,474 |
| Taushif | 2025-09-24 | 2025-11 | 20 | 6,225 |
| Taushif | 2025-09-24 | 2025-12 | 16 | 11,076 |

**Insight:** Customer activity often increases after account creation rather than declining. For example, Abdullah's first month (October, signup month) generated 16 orders, dropped to 8 the next month, then revenue rebounded in December. Ayon and Taushif show similar patterns — activity ramps up significantly in the 1-2 months after signup, sometimes peaking 2-3 months later (e.g., Ayon's revenue nearly doubled by month 3, Taushif's revenue peaked in his 4th month at ৳11,076). This suggests new customers take time to become fully engaged, highlighting an opportunity for onboarding campaigns in the first 60-90 days to accelerate this ramp-up period.

---

### Q15. Customers who ordered in October but not December

**Result (sample, 10 rows shown):**

| Customer ID | Name | Email |
|---|---|---|
| 2 | Ayon | ayon2@gmail.com |
| 5 | Samia | samia5@yahoo.com |
| 12 | Lamya | lamya12@gmail.com |
| 14 | Kamal | kamal14@yahoo.com |
| 15 | Hasib | hasib15@gmail.com |
| 16 | Heba | heba16@gmail.com |
| 17 | Zannat | zannat17@gmail.com |
| 21 | Mahjabin | mahjabin21@yahoo.com |
| 22 | Ehsan | ehsan22@gmail.com |
| 23 | Tanvir | tanvir23@gmail.com |

**Insight:** These customers were active in October but did not place any orders in December, indicating potential churn or a pause in engagement following UrbanCart's peak sales month. This list represents a key segment for re-engagement campaigns — e.g., targeted discounts or reminder emails — to win back customers before they become permanently inactive.

---

### Q16. Customers who ordered in both October and December

**Result (sample, 10 of 81 rows):**

| Customer ID | Name | Email |
|---|---|---|
| 1 | Abdullah | abdullah1@gmail.com |
| 3 | Taushif | taushif3@yahoo.com |
| 4 | Saiful | saiful4@gmail.com |
| 6 | Shithi | shithi6@gmail.com |
| 7 | Rumana | rumana7@gmail.com |
| 8 | Lamisa | lamisa8@outlook.com |
| 9 | Anika | anika9@gmail.com |
| 10 | Irtaza | irtaza10@outlook.com |
| 11 | Moumita | moumita11@gmail.com |
| 13 | Samia | samia13@gmail.com |

**Insight:** 81 out of 100 customers (81%) ordered in both October and December, showing strong overall retention across UrbanCart's peak and post-peak periods. Combined with Q15's findings (only 19 customers dropped off after October), this indicates UrbanCart has a loyal core customer base, though the smaller Q15 group still represents a valuable re-engagement opportunity.

---

### Q17. Which payment methods are used most frequently?

**Result:**

| Method | Usage Count | Percentage |
|---|---|---|
| COD | 488 | 40.67% |
| bKash | 349 | 29.08% |
| Nagad | 235 | 19.58% |
| Credit Card | 65 | 5.42% |
| Debit Card | 63 | 5.25% |

**Insight:** Cash on Delivery (COD) is by far the most popular payment method, used in 40.67% of all orders, followed by bKash (29.08%) and Nagad (19.58%) — together, these three methods account for nearly 90% of all transactions. Card payments (Credit + Debit) make up only about 10.7% combined, reflecting a strong preference for cash and mobile wallet payments in this market.

---

### Q18. Is there a relationship between payment method and order status?

**Result (sample):**

| Method | Status | Order Count |
|---|---|---|
| bKash | Completed | 202 |
| bKash | Pending | 74 |
| bKash | Cancelled | 73 |
| COD | Completed | 300 |
| COD | Cancelled | 97 |
| COD | Pending | 91 |
| Credit Card | Completed | 39 |
| Credit Card | Pending | 15 |
| Credit Card | Cancelled | 11 |
| Debit Card | Completed | 35 |

**Insight:** COD has the highest cancellation count (97 orders, ~19.9% of its total), and bKash has a similar cancellation rate (~20.9%, 73 of 349). This suggests both COD and bKash orders carry a slightly elevated cancellation risk — for COD, this is likely because customers face less commitment when no upfront payment is required, making it easier to cancel before delivery.

---

### Q19. Do certain cities prefer specific payment methods?

**Result (sample):**

| City | Method | Usage Count |
|---|---|---|
| Barishal | COD | 76 |
| Barishal | bKash | 44 |
| Barishal | Nagad | 28 |
| Barishal | Debit Card | 15 |
| Barishal | Credit Card | 10 |
| Chattogram | COD | 56 |
| Chattogram | bKash | 44 |
| Chattogram | Nagad | 34 |
| Chattogram | Credit Card | 4 |
| Chattogram | Debit Card | 2 |

**Insight:** COD is the dominant payment method across all cities, but its share varies — in Barishal, COD accounts for ~44% of payments, while in Chattogram it's ~38%. Chattogram shows a relatively stronger preference for Nagad (34 vs Barishal's 28) and notably weaker card usage, suggesting localized payment infrastructure or trust differences that could inform city-specific payment promotions.

---

### Q20. Are higher-value orders associated with specific payment methods?

**Result:**

| Method | Avg Order Value | Max Order Value |
|---|---|---|
| Nagad | 1,947.61 | 5,760.00 |
| Credit Card | 1,910.45 | 4,676.00 |
| bKash | 1,860.23 | 5,921.00 |
| COD | 1,841.72 | 7,190.00 |
| Debit Card | 1,829.71 | 4,920.00 |

**Insight:** Average order values are fairly consistent across all payment methods (within ~6% of each other), with Nagad having the highest average (৳1,947.61). However, COD has the highest single order value recorded (৳7,190), despite having a slightly below-average mean, suggesting that while COD is generally used for typical-sized orders, it's also occasionally chosen for large, high-value purchases.

---

### Q21. What is the average number of items per order by payment method?

**Result:**

| Method | Avg Items per Order |
|---|---|
| Debit Card | 10.51 |
| Nagad | 10.11 |
| COD | 9.92 |
| Credit Card | 9.86 |
| bKash | 9.82 |

**Insight:** Basket size is remarkably consistent across payment methods (all between ~9.8 and 10.5 items), with Debit Card users having marginally larger baskets. This suggests payment method choice is more about convenience/trust preference than order size — customers don't significantly change how they pay based on how much they're buying.

---

### Q22. Difference between category average price and each product's price

**Result (sample, 10 of 41 rows):**

| Product Name | Category | Unit Price | Category Avg Price | Price Difference |
|---|---|---|---|---|
| Bru Coffee 200g | Beverages | 330.00 | 137.00 | +193.00 |
| Taaza Black Tea 400g | Beverages | 190.00 | 137.00 | +53.00 |
| Pepsi 1L | Beverages | 75.00 | 137.00 | -62.00 |
| Sprite 1L | Beverages | 70.00 | 137.00 | -67.00 |
| Water Bottle 1L | Beverages | 20.00 | 137.00 | -117.00 |
| Farm Fresh Milk 1L | Dairy | 90.00 | 90.00 | 0.00 |
| GP Internet Pack | Digital | 149.00 | 125.67 | +23.33 |
| Robi Internet Pack | Digital | 129.00 | 125.67 | +3.33 |
| Banglalink Internet Pack | Digital | 99.00 | 125.67 | -26.67 |
| Power Bank 10000mAh | Electronics | 950.00 | 600.00 | +350.00 |

**Insight:** Bru Coffee (৳330) is priced significantly above the Beverages category average (৳137), over double, while Water Bottle (৳20) sits well below at -৳117, showing wide price spread within this category. Power Bank 10000mAh is priced ৳350 above the Electronics average, yet (per Q8) it's UrbanCart's top revenue earner, suggesting premium pricing hasn't hurt its demand. In contrast, lower-priced items like Water Bottle and Banglalink Internet Pack may be positioned as budget/entry options to attract price-sensitive customers within their categories.

---

### Q23. Which product pairs are most frequently purchased together?

**Result:**

| Product 1 | Product 2 | Times Bought Together |
|---|---|---|
| Potato 1kg | Peanut 500g | 22 |
| Farm Fresh Milk 1L | Potato 1kg | 21 |
| Miniket Rice 5kg | Power Bank 10000mAh | 18 |
| Fresh Sugar 1kg | Sprite 1L | 18 |
| Onion 1kg | Shoes Polish | 18 |
| Flour (Atta) 2kg | Cap | 18 |
| ACI Pure Salt 1kg | Farm Fresh Milk 1L | 17 |
| Deshi Egg (12 pcs) | GP Internet Pack | 17 |
| Fresh Sugar 1kg | Oral Saline (ORS) | 17 |
| Bru Coffee 200g | Oral Saline (ORS) | 17 |

**Insight:** Potato 1kg appears in 2 of the top 3 pairs (with Peanut 500g and Farm Fresh Milk), suggesting it's a frequent "anchor" item in grocery baskets — customers buying potatoes often add other staples. Notably, this differs from Q24's revenue-based pairs (dominated by Power Bank), showing that the most frequently co-purchased items (everyday groceries) aren't always the highest revenue pairs (which involve higher-priced electronics). This means UrbanCart could use two different bundling strategies: grocery staple bundles (high frequency, lower margin) and grocery + electronics cross-promotions (lower frequency, higher revenue).

---

### Q24. Which product pairs generate the highest combined revenue when sold together?

**Result:**

| Product 1 | Product 2 | Combined Revenue |
|---|---|---|
| Miniket Rice 5kg | Power Bank 10000mAh | 58,450 |
| Bru Coffee 200g | Power Bank 10000mAh | 53,430 |
| Banglalink Internet Pack | Power Bank 10000mAh | 41,267 |
| Broiler Chicken (whole) | Power Bank 10000mAh | 41,100 |
| Miniket Rice 5kg | Nazirshail Rice 5kg | 37,310 |
| Nazirshail Rice 5kg | Power Bank 10000mAh | 36,140 |
| Wheel Washing Powder 1kg | Power Bank 10000mAh | 34,010 |
| T-shirt (Women) | Power Bank 10000mAh | 32,870 |
| Taaza Black Tea 400g | Power Bank 10000mAh | 32,490 |
| Nazirshail Rice 5kg | Wallet (Men) | 32,460 |

**Insight:** Power Bank 10000mAh appears in 8 of the top 10 highest-revenue product pairs, unsurprising given it's UrbanCart's single highest revenue product (Q8). The Miniket Rice 5kg + Power Bank combination generates the most combined revenue (৳58,450), while Miniket Rice + Nazirshail Rice (two grocery staples) is the only top-10 pair not involving the Power Bank, showing groceries are often bought together too. This strongly suggests bundling the Power Bank with high-traffic grocery items (rice, cooking essentials) as a cross-category promotion.

---

### Q25. Daily report (Date, Total Orders, Total Items, Completed Orders, Cancelled Orders, Total Revenue)

**Result (sample, 10 of 90 days — September 2025):**

| Date | Total Orders | Total Items | Completed | Cancelled | Total Revenue |
|---|---|---|---|---|---|
| 2025-09-01 | 15 | 154 | 10 | 0 | 24,172 |
| 2025-09-02 | 11 | 105 | 7 | 1 | 16,110 |
| 2025-09-03 | 14 | 135 | 8 | 3 | 29,315 |
| 2025-09-04 | 21 | 201 | 14 | 2 | 32,249 |
| 2025-09-05 | 8 | 73 | 3 | 1 | 11,946 |
| 2025-09-06 | 6 | 60 | 6 | 0 | 10,393 |
| 2025-09-07 | 13 | 124 | 8 | 2 | 20,656 |
| 2025-09-08 | 13 | 131 | 10 | 1 | 24,629 |
| 2025-09-09 | 12 | 129 | 8 | 4 | 27,080 |
| 2025-09-10 | 20 | 198 | 13 | 2 | 38,096 |

**Insight:** Daily order volume fluctuates between roughly 6-21 orders, with revenue ranging from ৳10,393 to ৳38,096 — September 4th and 10th stand out as high-performing days (20+ orders, ৳32K-38K revenue), while September 6th was the slowest. Cancellation counts are generally low (0-4 per day) and don't show an obvious pattern tied to order volume. This day-by-day view is useful for spotting demand spikes (potentially tied to promotions or paydays) and planning inventory/staffing accordingly.

---

## Charts & Visualizations

*(Insert chart images here, e.g.:)*
- Revenue by City (Bar Chart) — based on Q2
- Revenue by Category (Pie/Bar Chart) — based on Q7
- Monthly Order Trend (Line Chart) — based on Q4
- Payment Method Distribution (Pie Chart) — based on Q17
- Purchasing Patterns by Gender & Category (Grouped Bar Chart) — based on Q13
- Daily Orders & Revenue Trend (Line Chart) — based on Q25

---

## Key Insights Summary

- **Revenue is concentrated outside the capital.** Barishal, Sylhet, and Chattogram lead in both order volume and revenue — Dhaka ranks only 9th, showing UrbanCart's customer base is spread across regional cities.
- **Fashion and Grocery drive the business.** These two categories make up roughly 45% of total revenue, with the Power Bank 10000mAh standing out as the single highest-revenue product overall.
- **Basket sizes are small.** The average order contains just ~2.5 items worth ৳1,871 — there's clear room to grow revenue per order through bundling and cross-selling.
- **Inventory is under pressure.** Several top-selling products (notably Power Bank 10000mAh and Bru Coffee 200g) have already sold more units than current stock allows, risking lost sales if not restocked.
- **Customer retention is strong but not universal.** 81% of customers ordered in both October and December, but a smaller group (Q15) went quiet after October and represents a re-engagement opportunity.
- **Cash and mobile wallets dominate payments.** COD, bKash, and Nagad account for nearly 90% of transactions, with COD and bKash showing the highest cancellation rates (~20%).
- **Gender differences exist in purchasing volume.** Male customers generate higher revenue and order more frequently across nearly all categories, while female customers show comparatively stronger per-order Fashion spending.

---

## Business Recommendations

- **Prioritize restocking for at-risk products**, especially Power Bank 10000mAh and Bru Coffee 200g, where demand has already exceeded available stock — delaying this risks ongoing lost sales on UrbanCart's best-selling items.
- **Launch a VIP/loyalty program for top revenue customers** (e.g., Raisa, Mim, Sakib) and high-performing cities (Barishal, Sylhet, Chattogram, Cumilla) to reinforce retention in UrbanCart's strongest segments.
- **Run re-engagement campaigns targeting the ~19 customers who ordered in October but not December**, using discounts or reminders to recover this at-risk segment before churn becomes permanent.
- **Introduce product bundles using two strategies**: (1) grocery staple bundles based on frequently co-purchased items like Potato + Peanut or Potato + Milk, and (2) cross-category bundles pairing the Power Bank with high-traffic grocery items (e.g., rice), to increase the average basket size beyond its current ~2.5 items.
- **Review COD and bKash order handling**, since both show cancellation rates near 20% — investigating delivery reliability or confirmation processes for these methods could reduce lost revenue from cancelled orders.
- **Investigate Dhaka's relatively low performance** despite being a major urban center — this could indicate untapped growth potential through targeted marketing or improved delivery coverage in the capital.
- **Use the October sales surge as a model** for future promotions — understanding what drove October's order spike (vs September and December) could help replicate that demand in other months.

---

## Tools Used

- **PostgreSQL** – database & query engine
- **pgAdmin 4** – database management and query execution
- **DrawSQL** – ER diagram design
- **Excel / Google Sheets** – chart creation

---

## How to Run This Project

1. Create the database tables (see schema above).
2. Import the provided CSV files into their respective tables using pgAdmin's Import/Export tool, in this order: customers → products → orders → order items → payments.
3. Run each `.sql` file listed in the [SQL Files](#sql-files) section to reproduce the analysis for each business question.

---

## Author

Built as a personal SQL data analysis portfolio project.
