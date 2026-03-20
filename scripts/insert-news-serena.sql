-- News #1: Serena DevNote (Character Preview + Developer Note)
INSERT INTO news (
  title,
  title_th,
  category,
  summary_th,
  content,
  content_th,
  thumbnail,
  source_url,
  source_key,
  published_at
) VALUES (
  'New Character: Serena (세레나) — Developer Note',
  'ตัวละครใหม่: เซเรนา (Serena) — บันทึกนักพัฒนา',
  'character',
  'เซเรนา ตัวละครใหม่สายปืนใหญ่ ทายาทตระกูลเบเดล ผู้ทิ้งยศศักดิ์มาเป็นช่างปืนในทวีปใหม่ มาพร้อมระบบ "แปลงร่าง" (개조) สลับโหมดระหว่าง Output กับ Rapid เพื่อเพิ่มดาเมจสูงสุด',
  '',
  '<article>
<h1>เซเรนา (Serena / 세레나) — ตัวละครใหม่</h1>

<img src="/img/news/serena-devnote/serena-character-art.jpg" alt="ภาพตัวละครเซเรนา Granado Espada" />

<h2>ประวัติตัวละคร</h2>

<p>เซเรนา เป็นบุตรีคนเล็กของผู้ดูแลดัชชีเบเดล (Bedel Duchy) เธอถูกเลี้ยงดูมาอย่างสมเกียรติตามแบบฉบับตระกูลขุนนาง แต่ชีวิตเปลี่ยนไปตลอดกาลเมื่อบิดาของเธอถูกเนรเทศหลัง "เหตุการณ์นองเลือดแบร์นิเอ" (Bloody Bernie Incident)</p>

<p>ถูกรังเกียจจากครอบครัวของตนเอง เซเรนาจึงตัดสินใจทิ้งทุกสิ่งที่เกี่ยวข้องกับตระกูลเบเดลโดยสมัครใจ เธออพยพมายังทวีปใหม่ (New Continent) และประกอบอาชีพเป็นช่างเทคนิคอาวุธและช่างปืน</p>

<p>ดังที่ผู้พัฒนา Dunlaine กล่าวไว้ว่า: <em>"เซเรนาเลือกเดินออกจากตระกูลด้วยตัวเอง ทิ้งทุกสิ่งที่เกี่ยวข้องไว้เบื้องหลัง"</em></p>

<h2>อาวุธและเกราะ</h2>

<p><strong>อาวุธ:</strong> ปืนลำกล้องใหญ่ (Large-caliber Rifle)<br />
<strong>เกราะ:</strong> เสื้อคลุม (Coat Armor)</p>

<h2>ระบบแปลงร่าง (개조 / Modification System)</h2>

<p>กลไกหลักของเซเรนาคือ ระบบ "แปลงร่าง" ที่จะสลับสถานะบัฟโดยอัตโนมัติเมื่อใช้สกิลต่าง ๆ แบ่งเป็น 2 โหมด:</p>

<img src="/img/news/serena-devnote/buff-table-0.png" alt="ตารางระบบบัฟแปลงร่างของเซเรนา" />

<table>
<tr><th>สถานะบัฟ</th><th>สกิลที่เปลี่ยนเข้าโหมดนี้</th><th>ดาเมจโบนัส</th></tr>
<tr><td><strong>แปลงร่าง-กำลัง (Output Mode / 개조-출력)</strong></td><td>ติร์ เดอ ซูติยง, ฟู กงแวร์ซ็อง, เรเอกีปม็อง</td><td>+50% ฐาน, แตกต่างตามสกิล</td></tr>
<tr><td><strong>แปลงร่าง-ระดมยิง (Rapid Mode / 개조-연발)</strong></td><td>ปัวตาจ, ติราอิยาจ, เรเอกีปม็อง</td><td>+50% ฐาน, แตกต่างตามสกิล</td></tr>
</table>

<h2>สกิลทั้งหมด</h2>

<h3>1. เรเอกีปม็อง (Reequipement / 레에키프망)</h3>
<p>สกิลบำรุงรักษาและแปลงร่างปืน — เป็นสกิลหลักที่เปลี่ยนสถานะบัฟ</p>

<img src="/img/news/serena-devnote/skill-reequipement.gif" alt="สกิล Reequipement ของเซเรนา" />

<p><strong>ค่าสถิติจากเรเอกีปม็อง:</strong></p>
<ul>
<li>เกรดโจมตี +1 (Attack Grade +1)</li>
<li>พลังโจมตี +50% (Attack Power +50%)</li>
<li>ค่าเจาะเกราะกายภาพ +25 (Physical Penetration +25)</li>
<li>ค่าแม่นยำ +25 (Accuracy +25)</li>
</ul>

<h3>2. ซูเวอนีร์ เรเวย์ (Souvenir Reveille / 수베니어 르베)</h3>
<p>สกิลท่าทางความชัดเจนทางจิตใจ — เพิ่มดาเมจ +50% เมื่อต่อสู้กับมอนสเตอร์</p>

<img src="/img/news/serena-devnote/skill-souvenir-reveille.gif" alt="สกิล Souvenir Reveille ของเซเรนา" />

<h3>3. ปัวตาจ (Pouatage / 푸아타쥬)</h3>
<p>สกิลยิงถล่มอย่างรวดเร็ว — เมื่ออยู่ในโหมดระดมยิง (Rapid Mode) ดาเมจ x2</p>

<img src="/img/news/serena-devnote/skill-pouatage.gif" alt="สกิล Pouatage ของเซเรนา" />

<h3>4. ติร์ เดอ ซูติยง (Tir de Soutien / 티어 드 수티앙)</h3>
<p>สกิลขว้างระเบิด — เมื่ออยู่ในโหมดกำลัง (Output Mode) ดาเมจ x3, โอกาสเผาไหม้ 40%</p>

<img src="/img/news/serena-devnote/skill-tirage-dappui.gif" alt="สกิล Tirage d''Appui ของเซเรนา" />

<h3>5. ติราอิยาจ (Tiraillage / 티라이아쥬)</h3>
<p>สกิลยิงต่อเนื่อง + ยิงนัดทรงพลัง — เมื่ออยู่ในโหมดระดมยิง (Rapid Mode) ดาเมจ x3, โอกาสบาดแผลวิกฤต 40%</p>

<h3>6. ฟู กงแวร์ซ็อง (Fouconvertang / 푸 콩베르쟝)</h3>
<p>สกิลยิงสะเก็ดระเบิดพิเศษ — เมื่ออยู่ในโหมดกำลัง (Output Mode) ดาเมจ x4, โอกาสช็อก 50%</p>

<img src="/img/news/serena-devnote/skill-fouconvertang.gif" alt="สกิล Fouconvertang ของเซเรนา" />

<h2>หมายเหตุจากนักพัฒนา</h2>

<p>ผู้พัฒนา Dunlaine กล่าวว่าตัวละครใหม่ต่อจากนี้จะมาพร้อมชุดคอสตูมเฉพาะตั้งแต่วันเปิดตัว</p>

<p><em>ที่มา: <a href="https://ge.hanbiton.com/Comm/DevNote/View.aspx?postKey=668125">ge.hanbiton.com — DevNote</a></em></p>
</article>',
  '/img/news/serena-devnote/serena-character-art.jpg',
  'https://ge.hanbiton.com/Comm/DevNote/View.aspx?postKey=668125',
  'devnote-668125-serena',
  '2026-03-19'
);
