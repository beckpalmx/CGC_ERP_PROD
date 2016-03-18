// ** I18N

// Calendar EN language
// Author: Mihai Bazon, <mihai_bazon@yahoo.com>
// Encoding: any
// Distributed under the same terms as the calendar itself.

// For translators: please use UTF-8 if possible.  We strongly believe that
// Unicode is the answer to a real internationalized world.  Also please
// include your contact information in the header, as can be seen above.

// full day names
Calendar._DN = new Array
("Sunday",
 "Monday",
 "Tuesday",
 "Wednesday",
 "Thursday",
 "Friday",
 "Saturday",
 "Sunday");

// Please note that the following array of short day names (and the same goes
// for short month names, _SMN) isn't absolutely necessary.  We give it here
// for exemplification on how one can customize the short day names, but if
// they are simply the first N letters of the full name you can simply say:
//
//   Calendar._SDN_len = N; // short day name length
//   Calendar._SMN_len = N; // short month name length
//
// If N = 3 then this is not needed either since we assume a value of 3 if not
// present, to be compatible with translation files that were written before
// this feature.

// short day names
Calendar._SDN = new Array
("อา.",
 "จ.",
 "อัง.",
 "พ.",
 "พฤ.",
 "ศ.",
 "ส.",
 "อา.");

// First day of the week. "0" means display Sunday first, "1" means display
// Monday first, etc.
Calendar._FD = 0;

// full month names
Calendar._MN = new Array
("มกราคม",
 "กุมภาพันธ์",
 "มีนาคม",
 "เมษายน",
 "พฤษภาคม",
 "มิถุนายน",
 "กรกฏาคม",
 "สิงหาคม",
 "กันยายน",
 "ตุลาคม",
 "พฤศจิกายน",
 "ธันวาคม");

// short month names
Calendar._SMN = new Array
("มก.",
 "กพ.",
 "มีค.",
 "เมย.",
 "พค.",
 "มิย.",
 "กค.",
 "สค.",
 "กย.",
 "ตค.",
 "พย.",
 "ธค.");

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = "เกี่ยวกับ Calendar";

Calendar._TT["ABOUT"] =
"DHTML Date/Time Selector\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this this ;-)
"เวอร์ชันล่าสุดที่ : http://www.dynarch.com/projects/calendar/\n" +
"Distributed under GNU LGPL.  See http://gnu.org/licenses/lgpl.html for details." +
"\n\n" +
"Date selection:\n" +
"- ใช้งานปุ่ม \xab, \xbb เพื่อเลือกปี\n" +
"- ใช้งานปุ่ม " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " เพื่อเลือกเดือน\n" +
"- กดปุ่มเมาส์ค้างไว้ เหนือปุ่มที่ต้องการเพื่อเลือกได้เร็วขึ้น.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"Time selection:\n" +
"- คลิ๊กในส่วนของ time เพื่อเพิ่มเวลาขึ้น\n" +
"- หรือ Shift-click เพื่อลดเวลาลง\n" +
"- หรือ คลิ๊กและทำการลากเพื่อความรวดเร็ว.";

Calendar._TT["PREV_YEAR"] = "ปีก่อนหน้า (กดค้างเพื่อแสดงเมนู)";
Calendar._TT["PREV_MONTH"] = "เดือนก่อนหน้า (กดค้างเพื่อแสดงเมนู)";
Calendar._TT["GO_TODAY"] = "ไป วันที่ปัจจุบัน";
Calendar._TT["NEXT_MONTH"] = "เดือนถัดไป (กดค้างเพื่อแสดงเมนู)";
Calendar._TT["NEXT_YEAR"] = "ปีถัดไป (กดค้างเพื่อแสดงเมนู)";
Calendar._TT["SEL_DATE"] = "เลือกวัน";
Calendar._TT["DRAG_TO_MOVE"] = "ลากเพื่อย้ายตำแหน่ง";
Calendar._TT["PART_TODAY"] = " (วันปัจจุบัน)";

// the following is to inform that "%s" is to be the first day of week
// %s will be replaced with the day name.
Calendar._TT["DAY_FIRST"] = "แสดง %s ก่อน";

// This may be locale-dependent.  It specifies the week-end days, as an array
// of comma-separated numbers.  The numbers are from 0 to 6: 0 means Sunday, 1
// means Monday, etc.
Calendar._TT["WEEKEND"] = "0,6";

Calendar._TT["CLOSE"] = "ปิด";
Calendar._TT["TODAY"] = "วันปัจจุบัน";
Calendar._TT["TIME_PART"] = "(Shift-)คลิ๊ก หรือ ลาก เพื่อเปลี่ยนแปลงค่า";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%Y-%m-%d";
Calendar._TT["TT_DATE_FORMAT"] = "%a, %b %e";

Calendar._TT["WK"] = "สัปดาห์";
Calendar._TT["TIME"] = "เวลา:";
