// ملف الرسائل الخاصة بالمشاكل في التطبيق
class AppError{
  // رسائل الاتصال بالإنترنت
  static const messageNoInternet = "تحقق من توفر الإنترنت.";
  static const messageInternetSlow = "سرعة الإنترنت بطيئة، يرجى الانتظار...";
  static const messageNetworkError = "حدث خطأ في الاتصال بالشبكة، حاول مرة أخرى.";

  // رسائل تسجيل الدخول
  static const messageLoginFailed = "فشل تسجيل الدخول، تأكد من اسم المستخدم وكلمة المرور.";
  static const messageAccountLocked = "حسابك مقفل مؤقتًا، يرجى المحاولة لاحقًا.";
  static const messageEmptyField = "يرجى ملء جميع الحقول المطلوبة.";


  // رسائل التسجيل
  static const messageRegistrationFailed = "فشل التسجيل، يرجى التحقق من المعلومات المدخلة.";
  static const messageEmailExists = "البريد الإلكتروني الذي أدخلته موجود بالفعل.";

  // رسائل البيانات
  static const messageDataNotFound = "لا توجد بيانات متاحة.";
  static const messageInvalidInput = "المدخلات غير صحيحة. يرجى التحقق مرة أخرى.";

  // رسائل التحديث
  static const messageUpdateFailed = "فشل تحديث البيانات. حاول مرة أخرى.";

  // رسائل التحميل
  static const messageLoadingFailed = "فشل تحميل المحتوى، تحقق من اتصالك بالإنترنت.";

  // رسائل التفاعل مع المستخدم
  static const messageActionFailed = "فشلت العملية. حاول مرة أخرى.";


  // رسائل الأخطاء العامة
  static const messageUnexpectedError = "حدث خطأ غير متوقع، يرجى المحاولة لاحقًا.";


  // رسائل الأخطاء العامة المتعلقة بالدفع
  static const messageUnexpectedPaymentError = "حدث خطأ غير متوقع أثناء معالجة الدفع. يرجى المحاولة لاحقًا.";

  // رسائل استرداد الأموال
  static const messageRefundFailed = "فشل استرداد الأموال. يرجى التحقق من الحالة مع الدعم الفني.";

  // رسائل الاشتراك
  static const messageSubscriptionFailed = "فشل الاشتراك. تحقق من تفاصيل الدفع.";

  // رسائل البحث
  static const messageNoSearchResults = "لم يتم العثور على نتائج. حاول البحث بكلمات أخرى.";

}

