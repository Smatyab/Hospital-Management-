//const host = "https://crowded-galoshes-elk.cyclic.app";
const host = "https://node-hophsee.onrender.com";

//const host = "http://192.168.2.172:8000";

const userEp = "$host/users";
const loginUserEp = "$userEp/login";
const doctorEp = "$host/doctors";
const loginDoctorEp = "$doctorEp/login";
const paymentEp = "$host/payments";
const appoEp = "$host/appoinments";
const patientEp = "$host/patients";
const appoUpcomingEP = "$appoEp/upcoming";
const appoApprovedEP = "$appoEp/approved";
const appoCancelledEP = "$appoEp/cancelled";
const appoExpiredEP = "$appoEp/expired";

const DOCTOR_ID_PREFERENCE = "doctor_id";
const USER_ID_PREFERENCE = "user_id";
const NAME_PREFERENCE = "name";
const IMAGE_URL_PREFERENCE = "image_url";
const IS_DOCTOR_PREFERENCE = "is_doctor";
const IS_LOGIN_PREFERENCE = "is_login";
const APPO_DATE_PREFERENCE = "appo_date";
const APPO_TIME_PREFERENCE = "appo_time";

const APPO_TYPE_UPCOMING = "Upcoming";
const APPO_TYPE_APPROVED = "Approved";
const APPO_TYPE_CANCELLED = "Cancelled";
const APPO_TYPE_EXPIRED = "Expired";
