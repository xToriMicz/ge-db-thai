-- Update News: Serena DevNote — Round 4 (Human-quality article layout)
-- Applies: TL;DR box, skill cards, figure+caption, pull quotes, Q&A cards,
--          gallery grid, proper content flow, whitespace
UPDATE news SET
  content_th = '<article>

<p>เซเรนา คือตัวละครใหม่ล่าสุดของ Granado Espada — ทายาทตระกูลเบเดลผู้ทิ้งทุกอย่างไว้เบื้องหลัง มาพร้อมระบบ "แปลงร่าง" ที่สลับโหมดการต่อสู้แบบไม่เคยมีมาก่อน</p>

<div class="tldr">
<strong>สรุปสั้น:</strong> เซเรนา ใช้ปืนลำกล้องใหญ่ + เสื้อคลุม มาพร้อมสแตนซ์ Remodeler ที่มี 5 สกิลหลัก สลับระหว่างโหมดกำลัง (Output) กับระดมยิง (Rapid) — ดาเมจสูงสุด x4 ในโหมดกำลัง
</div>

<figure>
<img src="/img/news/serena-devnote/preview-main_bg.jpg" alt="เซเรนา — ภาพหลักตัวละครใหม่ Granado Espada" />
<figcaption>เซเรนา (Serena / 세레나) — ตัวละครใหม่จากตระกูลเบเดล พร้อมปืนลำกล้องใหญ่ประจำตัว</figcaption>
</figure>

<h2>ประวัติตัวละคร</h2>

<figure>
<img src="/img/news/serena-devnote/preview-story.png" alt="ฉากเรื่องราวของเซเรนา" />
<figcaption>ฉากจากเหตุการณ์ในอดีตของตระกูลเบเดล</figcaption>
</figure>

<p>เซเรนา เป็นบุตรีคนเล็กของอดีตดยุคเบเดล (Bedel) ผู้ปกครองเมืองปกครองที่ตั้งชื่อตามตระกูล เธอถูกเลี้ยงดูมาอย่างสมเกียรติตามแบบฉบับตระกูลขุนนาง และเคยฝึกฝนการใช้อาวุธปืนร่วมกับ <strong>มงต์บลอง (Montblanc)</strong> ซึ่งเป็นลูกพี่ลูกน้องของเธอ</p>

<p>ชีวิตเปลี่ยนไปตลอดกาลเมื่อเกิด <strong>"เหตุการณ์นองเลือดแบร์นิเอ" (Bloody Bernié Incident)</strong> — การสังหารหมู่ที่ถูกหยุดยั้งโดยเฮอร์เบิร์ต (Herbert) เด็กสาวผู้ได้รับฉายาว่า <strong>"แสงวาบสีเงิน" (은빛 섬광 / Silver Flash)</strong></p>

<p>แม้เซเรนาจะไม่ได้มีส่วนเกี่ยวข้องโดยตรงกับเหตุการณ์นี้ แต่เมื่อบิดาถูกเนรเทศ ทั้งตระกูลก็หันหลังให้เธอ</p>

<blockquote>เธอถูกเมินเฉยราวกับไม่มีตัวตนเป็นเวลา <strong>1 ปีเต็ม</strong> — ไม่มีใครในตระกูลพูดด้วยหรือแม้แต่มองเธอ</blockquote>

<p>เมื่อทนไม่ไหว เซเรนาจึงตัดสินใจทิ้งทุกสิ่งที่เกี่ยวข้องกับตระกูลเบเดลโดยสมัครใจ อพยพมายังทวีปใหม่ (New Continent) และประกอบอาชีพเป็นช่างเทคนิคอาวุธและช่างปืน</p>

<p>นี่เป็นตัวละครตัวแรกที่เชื่อมโยงกับตระกูลขุนนางเบเดลนับตั้งแต่มงต์บลอง</p>

<h2>อาวุธและเกราะ</h2>

<figure>
<img src="/img/news/serena-devnote/preview-info_bg.jpg" alt="เซเรนา เต็มตัวในชุดทหารสีน้ำเงินพร้อมปืนประดับ" />
<figcaption>เซเรนาในชุดทหารสีน้ำเงิน พร้อมปืนลำกล้องใหญ่ประดับลวดลาย</figcaption>
</figure>

<div class="info-box">
<strong>อาวุธ:</strong> ปืนลำกล้องใหญ่ (Large-caliber Rifle)<br />
<strong>เกราะ:</strong> เสื้อคลุม (Coat Armor)
</div>

<h2>ระบบแปลงร่าง (Modification System)</h2>

<p>กลไกหลักของเซเรนาคือระบบ "แปลงร่าง" — เมื่อใช้สกิลแต่ละตัว สถานะบัฟจะสลับโดยอัตโนมัติระหว่าง 2 โหมด ผู้เล่นแค่ต้องจำว่าสกิลไหนเข้าโหมดไหน</p>

<h3>บัฟร่วม (ใช้ทั้ง 2 โหมด)</h3>

<div class="info-box">
ระยะเวลา: 400 วินาที · เกรดโจมตี +1 · พลังโจมตี +50% · เจาะเกราะกายภาพ +25 · ค่าแม่นยำ +25
</div>

<h3>บัฟเฉพาะโหมด</h3>

<table>
<tr><th>โหมด</th><th>เอฟเฟกต์เฉพาะ</th><th>สกิลที่เข้าโหมดนี้</th></tr>
<tr><td><strong>กำลัง (Output)</strong></td><td>เจาะเกราะกายภาพ +10</td><td>ฟูเอตาจ, ติราปาจ, เรเอกีปม็อง</td></tr>
<tr><td><strong>ระดมยิง (Rapid)</strong></td><td>ปลดล็อกขีดจำกัดความเร็วโจมตี</td><td>ติร์ เดอ ซูติยง, ฟู กงแวร์ซ็อง, เรเอกีปม็อง</td></tr>
</table>

<h2>คลาสสกิล</h2>

<div class="skill-card">
<h4>เรเอกีปม็อง (Réequipement)</h4>
<div class="skill-sub">레에키프망 · คลาสสกิล — บำรุงรักษาและแปลงร่างปืน</div>
<p>สกิลหลักที่สลับสถานะบัฟระหว่าง 2 โหมด สามารถเข้าได้ทั้งโหมดกำลังและระดมยิง</p>
</div>

<h2>สแตนซ์: รีมาดเลอร์ (Remodeler / 리마들러)</h2>

<div class="skill-card">
<h4>1. ซูเวอนีร์ แรฟ (Souvenir Rêve)</h4>
<div class="skill-sub">수베니어 르베 · สกิลท่าทีตัดขาดจากอดีต</div>
<img class="skill-gif" src="/img/news/serena-devnote/skill-reequipement.gif" alt="สกิล Souvenir Rêve ของเซเรนา" />
<p>เพิ่มพลังโจมตีเมื่อต่อสู้กับมอนสเตอร์ — เป็นบัฟที่เสริมดาเมจให้สกิลอื่นทั้งหมด</p>
<ul>
<li>ระยะเวลา: 400 วินาที</li>
<li>เกรดโจมตี +1</li>
<li>พลังโจมตีมอนสเตอร์ +50%</li>
<li>ละเลยป้องกัน [ยิง] +10%</li>
<li>เทคนิค +5</li>
</ul>
</div>

<div class="skill-card">
<h4>2. ฟูเอตาจ (Fuetage)</h4>
<div class="skill-sub">푸아타쥬 · ยิงถล่มอย่างรวดเร็ว · ละเลยป้องกัน 20</div>
<img class="skill-gif" src="/img/news/serena-devnote/skill-souvenir-reveille.gif" alt="สกิล Fuetage ของเซเรนา" />
<p>สกิลยิงถล่มเป้าหมายอย่างรวดเร็ว ใช้แล้วเปลี่ยนเข้าโหมดกำลัง</p>
<ul>
<li>ในสถานะ [ระดมยิง]: ดาเมจมอนสเตอร์ <strong>x2</strong></li>
<li>ใช้ซ้ำได้ — คูลดาวน์ลด 2 วินาทีเมื่อใช้ซ้ำ</li>
<li>→ เปลี่ยนเข้าโหมด <strong>[กำลัง]</strong></li>
</ul>
</div>

<div class="skill-card">
<h4>3. ติร์ เดอ ซูติยง (Tir de Soutien)</h4>
<div class="skill-sub">티어 드 수티앙 · กระสุนระเบิดควบคุมพื้นที่ · ละเลยป้องกัน 60</div>
<img class="skill-gif" src="/img/news/serena-devnote/skill-pouatage.gif" alt="สกิล Tir de Soutien ของเซเรนา" />
<p>ยิงกระสุนระเบิดสร้างความเสียหายเป็นวงกว้าง พร้อมโอกาสติดเปลวไฟ</p>
<ul>
<li>ในสถานะ [ซูเวอนีร์ แรฟ]: ดาเมจ <strong>x2</strong> (x1.5 กับผู้เล่น)</li>
<li>ในสถานะ [กำลัง]: ดาเมจมอนสเตอร์ <strong>x3</strong></li>
<li>โอกาสติดเปลวไฟ (Flame): <strong>20%</strong></li>
<li>คูลดาวน์: 21 วินาที · ใช้ได้สูงสุด 2 ครั้งต่อรอบ</li>
<li>→ เปลี่ยนเข้าโหมด <strong>[ระดมยิง]</strong></li>
</ul>
</div>

<div class="skill-card">
<h4>4. ติราปาจ (Tiraillage)</h4>
<div class="skill-sub">티라이아쥬 · ยิงถล่มต่อเนื่อง + นัดทรงพลัง · ละเลยป้องกัน 100</div>
<img class="skill-gif" src="/img/news/serena-devnote/skill-tirage-dappui.gif" alt="สกิล Tiraillage ของเซเรนา" />
<p>ยิงต่อเนื่องตามด้วยนัดทรงพลัง สร้างบาดแผลวิกฤตได้สูง</p>
<ul>
<li>ในสถานะ [ซูเวอนีร์ แรฟ]: ดาเมจ <strong>x2</strong> (x1.5 กับผู้เล่น)</li>
<li>ในสถานะ [ระดมยิง]: ดาเมจมอนสเตอร์ <strong>x3</strong></li>
<li>โอกาสบาดแผลวิกฤต (Critical Wound): <strong>40%</strong></li>
<li>ละเลยป้องกันเพิ่ม: (เทคนิค x 0.04)%</li>
<li>คูลดาวน์: 24 วินาที · ใช้ได้สูงสุด 2 ครั้งต่อรอบ</li>
<li>→ เปลี่ยนเข้าโหมด <strong>[กำลัง]</strong></li>
</ul>
</div>

<div class="skill-card">
<h4>5. ฟู กงแวร์ซ็อง (Feu Convergent)</h4>
<div class="skill-sub">푸 콩베르쟝 · ระเบิดสะเก็ดพิเศษ · ละเลยป้องกัน 100</div>
<img class="skill-gif" src="/img/news/serena-devnote/skill-fouconvertang.gif" alt="สกิล Feu Convergent ของเซเรนา" />
<p>ยิงระเบิดสะเก็ดพิเศษไปข้างหน้า ยิ่งโดนน้อยเป้าหมายยิ่งแรง — สกิลดาเมจสูงสุดของเซเรนา</p>
<ul>
<li>ยิงโดนเป้าหมายน้อย = ดาเมจมอนสเตอร์สูงสุด <strong>x2</strong></li>
<li>ในสถานะ [กำลัง]: ดาเมจมอนสเตอร์ <strong>x4</strong></li>
<li>โอกาสช็อก (Shock): <strong>50%</strong></li>
<li>ละเลยป้องกันเพิ่ม: (เทคนิค x 0.04)%</li>
<li>→ เปลี่ยนเข้าโหมด <strong>[ระดมยิง]</strong></li>
</ul>
</div>

<h2>ภาพในเกม</h2>

<p>ภาพตัวอย่างจากเซิร์ฟเวอร์ทดสอบ แสดงท่าทาง การต่อสู้ และเอฟเฟกต์สกิลของเซเรนา</p>

<div class="gallery">
<img src="/img/news/serena-devnote/screenshot-01.jpg" alt="เซเรนายืนโพสท่าในเมือง" />
<img src="/img/news/serena-devnote/screenshot-06.jpg" alt="เซเรนาบนสะพานพร้อมปืนประจำตัว" />
<img src="/img/news/serena-devnote/screenshot-10.jpg" alt="เซเรนาในการต่อสู้ — เปลวไฟสีฟ้า" />
<img src="/img/news/serena-devnote/screenshot-15.jpg" alt="เซเรนาในสนามรบ" />
</div>

<h2>ถาม-ตอบกับนักพัฒนา</h2>

<div class="qa-item">
<div class="qa-q">ทำไมถึงเลือกตระกูลเบเดล?</div>
<div class="qa-a"><strong>Dunlain:</strong> ต้องการเชื่อมโยงกับตัวละครในตระกูลที่มีอยู่แล้ว เซเรนาเป็นตัวละครตัวแรกที่ผูกกับตระกูลเบเดลนับตั้งแต่มงต์บลอง ซึ่งทำให้มีมิติด้านเรื่องราวที่ลึกขึ้น</div>
</div>

<div class="qa-item">
<div class="qa-q">ระบบสลับโหมดดูซับซ้อน — ผู้เล่นจะเข้าใจไหม?</div>
<div class="qa-a"><strong>Dunlain:</strong> แม้ดูเหมือนซับซ้อน แต่หัวใจของการเล่นคือการสลับบัฟ — จำลำดับสกิลได้ก็เล่นได้คล่อง สกิลแต่ละตัวจะสลับโหมดโดยอัตโนมัติ ผู้เล่นแค่ต้องจำว่าสกิลไหนเข้าโหมดไหน</div>
</div>

<div class="qa-item">
<div class="qa-q">มีแผนเรื่องคอสตูมไหม?</div>
<div class="qa-a"><strong>Dunlain:</strong> ตัวละครใหม่ต่อจากนี้จะมาพร้อมชุดคอสตูมเฉพาะตั้งแต่วันเปิดตัว เซเรนาก็เช่นกัน</div>
</div>

<h2>สรุป</h2>

<p>เซเรนาเป็นตัวละครที่น่าสนใจทั้งด้านเรื่องราวและระบบการเล่น ประวัติที่เชื่อมโยงกับเหตุการณ์นองเลือดแบร์นิเอและตระกูลเบเดลให้ความลึกด้าน lore ขณะที่ระบบแปลงร่างสลับโหมดกำลัง/ระดมยิงเปิดโอกาสให้ผู้เล่นวางแผนคอมโบได้หลากหลาย</p>

<p>สำหรับผู้ที่ชอบตัวละครสาย DPS ระยะไกลที่มีกลไกการเล่นซับซ้อนแต่ให้ผลตอบแทนสูง — เซเรนาคือตัวเลือกที่ไม่ควรพลาด</p>

<p><em>ที่มา: <a href="https://ge.hanbiton.com/Comm/DevNote/View.aspx?postKey=668125">ge.hanbiton.com — DevNote #668125</a></em></p>

</article>',
  summary_th = 'เซเรนา ตัวละครใหม่สายปืนใหญ่จากตระกูลเบเดล — ทายาทผู้ทิ้งยศศักดิ์หลังเหตุการณ์นองเลือดแบร์นิเอ มาพร้อมสแตนซ์ Remodeler และระบบ "แปลงร่าง" สลับโหมดกำลัง/ระดมยิง พร้อมดาเมจสูงสุด x4',
  thumbnail = '/img/news/serena-devnote/preview-main_bg.jpg'
WHERE source_key = 'devnote-668125-serena';
