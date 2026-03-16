class AppTexts {
  AppTexts._();

  static const String appName = "Tulip Tea";
  static const String orderBookerName = "Tulip Tea Order Booker";
  static const String deliveryManName = "Tulip Tea Delivery Man";
  static const String orderBookerRoleName = "Order Booker";
  static const String deliveryManRoleName = "Delivery Man";
  static const String appVersion = "Version 1.0.0";

  // Onboarding
  static const String onBoardingTitle1 = "Seamless Shop Enrollment";
  static const String onBoardingSubtitle1 =
      "Register new shops instantly by capturing mandatory photos, CNIC details, and requesting credit limits on the go.";
  static const String onBoardingTitle2 = "Smart Route Navigation";
  static const String onBoardingSubtitle2 =
      "Access your 6-day schedule and auto-detect shop locations with real-time GPS tracking for validated visits.";
  static const String onBoardingTitle3 = "Master Your Recoveries";
  static const String onBoardingSubtitle3 =
      "Track outstanding dues, manage credit limits, and log every payment or recovery attempt with digital evidence.";

  // Delivery Man Onboarding
  static const String dmOnBoardingTitle1 = "Efficient Delivery Management";
  static const String dmOnBoardingSubtitle1 =
      "View all your assigned orders, manage deliveries, and track your daily performance with ease.";
  static const String dmOnBoardingTitle2 = "Warehouse Pickup";
  static const String dmOnBoardingSubtitle2 =
      "Pick up products from assigned warehouses with GPS verification and inventory tracking.";
  static const String dmOnBoardingTitle3 = "Proof of Delivery";
  static const String dmOnBoardingSubtitle3 =
      "Capture delivery photos, record GPS location, and collect payments with digital proof.";

  static const String getStarted = "Get Started";
  static const String next = "Next";
  static const String skip = "Skip";

  // Auth
  static const String login = "Login";
  static const String loginAs = "Login as a";
  static const String phoneNumber = "Phone Number";
  static const String password = "Password";
  static const String enterPhone = "Enter phone number";
  static const String enterPassword = "Enter password";
  static const String rememberMe = "Remember Me";
  static const String sessionExpired = "Session expired. Please log in again.";
  static const String invalidCredentials =
      "Incorrect phone number or password. Please try again.";
  static const String noInternetConnection =
      "No internet connection. Please check your network and try again.";
  static const String noConnection = "No Connection";

  // Main tabs - Order Booker
  static const String dashboard = "Dashboard";
  static const String shops = "Shops";
  static const String visits = "Visits";
  static const String creditLimits = "Credit Limits";
  static const String account = "Account";

  // Main tabs - Delivery Man
  static const String orders = "Orders";
  static const String deliveries = "Deliveries";
  static const String warehouses = "Warehouses";

  // Delivery Man Dashboard
  static const String activeDeliveries = "Active";
  static const String completedDeliveries = "Completed";
  static const String totalEarnings = "Total Earnings";
  static const String deliveriesSummary = "Deliveries Summary";
  static const String ordersSummary = "Orders Summary";
  static const String noCollectionsYet = "No collections yet";
  static const String viewAll = "View All";

  // Delivery Man Order Status
  static const String orderStatusNew = "New";
  static const String orderStatusPending = "Pending";
  static const String orderStatusDelivered = "Delivered";
  static const String orderStatusDisapproved = "Disapproved";
  static const String orderStatusReturned = "Returned";

  // Delivery Man Actions
  static const String pickupFromWarehouse = "Pickup From Warehouse";
  static const String deliverToShop = "Deliver To Shop";
  static const String returnToWarehouse = "Return To Warehouse";
  static const String markAsDelivered = "Mark as Delivered";
  static const String markAsDisapproved = "Mark as Disapproved";

  // Delivery Proof
  static const String deliveryProof = "Delivery Proof";
  static const String capturePhoto = "Capture Photo";
  static const String captureLocation = "Capture Location";
  static const String deliveryRemarks = "Delivery Remarks";
  static const String enterDeliveryRemarks = "Enter delivery remarks";

  // Warehouse
  static const String warehouseDetails = "Warehouse Details";
  static const String warehouseInventory = "Warehouse Inventory";
  static const String warehouseName = "Warehouse Name";
  static const String address = "Address";
  static const String contactPerson = "Contact Person";
  static const String contactPhone = "Contact Phone";
  static const String pickupQuantity = "Pickup Quantity";
  static const String returnQuantity = "Return Quantity";
  static const String availableStock = "Available Stock";
  static const String reservedQuantity = "Reserved";
  static const String productName = "Product";
  static const String totalItems = "Total Items";
  static const String totalItemsInStock = "Total Items in Stock";
  static const String productCode = "Code";
  static const String unit = "Unit";
  static const String available = "Available";
  static const String noInventoryYet = "No inventory items yet";

  // Collection
  static const String collectPayment = "Collect Payment";
  static const String dmCollectionAmount = "Collection Amount";
  static const String paymentCollected = "Payment Collected";
  static const String paymentCollectedBeforeDelivery =
      "Payment Collected Before Delivery";

  // No data messages
  static const String noAssignedOrdersYet = "No assigned orders yet";
  static const String noActiveDeliveries = "No active deliveries";
  static const String noCompletedDeliveries = "No completed deliveries";
  static const String noWarehousesAssigned = "No warehouses assigned";
  static const String myAssignedWarehouses = "My Assigned Warehouses";

  // Login role selection
  static const String selectLoginType = "Select Login Type";
  static const String loginAsOrderBooker = "Login as Order Booker";
  static const String loginAsDeliveryMan = "Login as Delivery Man";
  static const String selectRole = "Select Role";
  static const String changeRole = "Change Role";
  static const String selectRoleSubtitle = "Choose how you want to login";
  static const String continueAs = "Continue as";
  static const String switchToOrderBooker = "Switch to Order Booker";
  static const String switchToDeliveryMan = "Switch to Delivery Man";

  // Dashboard (wallet, schedule, transactions)
  static const String walletBalanceTitle = "Wallet Balance";
  static const String currentBalance = "Current Balance";
  static const String transactionHistory = "Transaction History";
  static const String mySchedule = "My Schedule";
  static const String assignedRoutes = "Assigned Routes";
  static const String myAssignedRoutes = " Assigned Routes";
  static const String daysScheduled = " Days Scheduled";
  static const String noTransactionsYet = "No transactions yet";
  static const String noScheduleYet =
      "No schedule assigned yet. Contact your distributor.";
  static const String refreshBalance = "Refresh";
  static const String credit = "Credit";
  static const String debit = "Debit";
  static const String balanceBefore = "Before";
  static const String balanceAfter = "After";
  static const String viewFull = "View Full History";
  static const String tapToExpand = "Tap to expand";
  static const String tapToCollapse = "Tap to collapse";

  // Shops
  static const String registerShop = "Register Shop";
  static const String myShops = "My Shops";
  static const String shopName = "Shop Name";
  static const String ownerName = "Owner Name";
  static const String ownerPhone = "Owner Phone";
  static const String gpsLocation = "GPS Location";
  static const String latitude = "Latitude";
  static const String longitude = "Longitude";
  static const String selectCurrentLocation = "Select Current Location";
  static const String openInMaps = "Open in Maps";
  static const String shopDetails = "Shop Details";
  static const String notAvailable = "Not available";
  static const String zone = "Zone";
  static const String route = "Route";
  static const String creditLimit = "Credit Limit";
  static const String legacyBalance = "Legacy Balance";
  static const String shopOwnerPhoto = "Shop Owner Photo";
  static const String shopPhoto = "Shop Photo";
  static const String ownerCnicFront = "Owner CNIC Front Photo";
  static const String ownerCnicBack = "Owner CNIC Back Photo";
  static const String selectZone = "Select Zone";
  static const String selectRoute = "Select Route";
  static const String loadingZones = "Loading zones...";
  static const String loadingRoutes = "Loading routes...";
  static const String noAssignedRoutesYet = "No assigned routes yet";
  static const String noShopsYet = "No shops registered yet";
  static const String registrationStatus = "Registration";
  static const String outstandingBalance = "Credit Consumed";
  static const String availableCredit = "Available Credit";
  static const String owner = "Owner";
  static const String gps = "GPS";
  static const String id = "ID";
  static const String created = "Created";
  static const String refreshList = "Refresh";
  static const String requestCreditLimitChange = "Request Credit Limit Change";
  static const String requestCreditLimitChangeDescription =
      "Select an existing shop and request to increase or decrease its credit limit.";
  static const String myCreditLimitRequests = "My Credit Limit Requests";
  static const String myRegisteredShops = "My Registered Shops";
  static const String registerShopVisit = "Register Shop Visit";
  static const String registerVisitDescription =
      "Record your visit to a shop. GPS coordinates can be captured automatically.";
  static const String myVisitHistory = "My Visit History";
  static const String requestId = "Request ID";
  static const String reviewed = "Reviewed";
  static const String currentLimit = "Current Limit";
  static const String requestedLimit = "Requested Limit";
  static const String location = "Location";
  static const String visitTimeLabel = "Visit Time";
  static const String notRecorded = "Not recorded";
  static const String viewPhoto = "View Photo";
  static const String routesLabel = "Routes";
  static const String orderId = "Order ID";
  static const String collectionId = "Collection ID";
  static const String visitId = "Visit ID";
  static const String enterValidRequestedCreditLimit =
      "Enter a valid requested credit limit";
  static const String noCreditLimitRequestsFound =
      "No credit limit requests found.";
  static const String selectShopAndEnterCreditLimit =
      "Select shop and enter a valid credit limit";
  static const String yourInformation = "Your Information";
  static const String assignedZone = "Assigned Zone";
  static const String yourAssignedRoutes = "Your Assigned Routes";
  static const String zoneIdLabel = "Zone";
  static const String rupeeSymbol = "Rs.";

  // Visits
  static const String registerVisit = "Register Visit";
  static const String visitHistory = "Visit History";
  static const String selectShop = "Select Shop";
  static const String visitTypes = "Visit Types";
  static const String orderBooking = "Order Booking";
  static const String dailyCollections = "Daily Collections";
  static const String inspection = "Inspection";
  static const String other = "Other";
  static const String visitTime = "Visit Time";
  static const String photo = "Photo";
  static const String reason = "Reason";
  static const String scheduledDeliveryDate =
      "Select to Schedule Delivery Date";
  static const String deliveryDate = "Delivery Date";
  static const String collectionAmount = "Collection Amount";
  static const String collectionRemarks = "Collection Remarks";
  static const String product = "Product";
  static const String selectProduct = "Select Product";
  static const String loadingProducts = "Loading products...";
  static const String noProductsYet = "No products available yet";
  static const String quantity = "Quantity";
  static const String noVisitsYet = "No visits yet";
  static const String createOrder = "Create Order";
  static const String submitCollection = "Submit Collection";
  static const String unitPrice = "Unit Price";
  static const String addOrderLine = "Add line";
  static const String pkr = "PKR";

  // Credit Limits
  static const String requestChange = "Request Change";
  static const String pendingRequests = "My Requests";
  static const String myRequests = "My Requests";
  static const String requestedCreditLimit = "Requested Credit Limit";
  static const String currentCreditLimit = "Current Credit Limit";
  static const String oldCreditLimit = "Previous";
  static const String remarks = "Remarks";
  static const String selectShopForRequest = "Select Shop";
  static const String noCreditRequestsYet = "No credit limit requests yet";
  static const String noPendingCreditRequestsYet =
      "No pending credit limit requests yet";
  static const String requestAgain = "Request Again";
  static const String requestAgainDescription =
      "Update the requested credit limit and remarks to submit your request again.";
  static const String distributorRemarks = "Distributor's remarks";
  static const String noRemarksFromDistributor = "No remarks from distributor";
  static const String requestDeletedByDistributor =
      "This request is deleted by distributor";
  static const String cannotResubmitDeletedRequest =
      "You can't resubmit the request because this request is deleted by the distributor.";
  static const String status = "Status";
  static const String approvedBy = "Approved by";
  static const String requestedBy = "Requested by";
  static const String linkToOrder = "Link to Order";
  static const String selectOrderOptional = "Select order";

  // Toast titles by status
  static const String success = "Success";
  static const String information = "Information";
  static const String warning = "Warning";

  // Errors / validation
  static const String error = "Error";
  static const String pleaseEnterPhoneAndPassword =
      "Please enter phone and password";
  static const String addPhoto = "Add Photo";
  static const String remove = "Remove";
  static const String camera = "Camera";
  static const String gallery = "Gallery";

  // Account
  static const String profile = "Profile";
  static const String fullName = "Full Name";
  static const String emailAddress = "Email Address";
  static const String logout = "Logout";

  // Common
  static const String noDataYet = "No data yet";
  static const String loading = "Loading";
  static const String loggingIn = "Logging in";
  static const String submitting = "Submitting";
  static const String registering = "Registering";
  static const String resubmitting = "Resubmitting";
  static const String selectingLocation = "Selecting location";
  static const String loggingOut = "Logging out";
  static const String gettingStarted = "Getting started";
  static const String submit = "Submit";
  static const String save = "Save";
  static const String cancel = "Cancel";

  // Shop register / validation
  static const String pleaseFillRequiredFields =
      "Please fill all required fields including CNIC photos";
  static const String couldNotReadCnicPhotos = "Could not read CNIC photos";
  static const String editShop = "Edit Shop";
  static const String resubmit = "Resubmit";
  static const String shopResubmittedSuccessfully =
      "Shop resubmitted successfully. It will be reviewed again.";
  static const String shopRegisteredSuccessfully =
      "Shop registered successfully";
  static const String pleaseLogInAgain = "Please log in again";
  static const String shopExteriorPhotoLabel = "Shop Exterior Photo";
  static const String ownerPhotoLabel = "Owner Photo";
  static const String zoneOptional = "Zone";
  static const String routeOptional = "Route";
  static const String creditLimitOptional = "Credit Limit";
  static const String finalTotalAmount = "Final Total Amount";
  static const String selectVisitTypes = "Select Visit Types";
  static const String addOrderItem = "Add Order Item";
  static const String orderItemsDuringVisit = "Order Items";
  static const String pleaseSelectShop = "Please select a shop";
  static const String addAtLeastOneProduct =
      "Add at least one product with quantity and unit price";
  static const String orderCreated = "Order created";
  static const String collectionSubmitted = "Collection submitted";
  static const String creditLimitRequestSubmitted =
      "Credit limit request submitted";
  static const String selectShopAndEnterValidAmount =
      "Select shop and enter a valid amount";
  static const String pleaseSelectShopAndVisitType =
      "Please select shop and at least one visit type";
  static const String visitRegisteredSuccessfully =
      "Visit registered successfully";
  static const String selectShopOptional = "Select Shop";
  static const String onlyShopsFromRoutesScheduledToday =
      "Only shops from routes scheduled for today are shown.";

  /// Use %s for day name (e.g. Monday).
  static const String noRoutesScheduledForTodayContactDistributor =
      "No routes scheduled for today (%s). Contact your distributor.";
  static const String todayShopsHint =
      "Today (%s): %s shop(s) from %s scheduled route(s) available.";
  static const String shopCreditInformation = "Shop Credit Information";
  static const String noteOrderUpToAvailableCredit =
      "You can only place orders up to the available credit amount. If you need to increase the credit limit, use the Credit Limits tab to request an increase.";
  static const String orderDetails = "Order Details";
  static const String calculatedTotal = "Calculated Total";
  static const String finalOrderAmountOptional = "Final Order Amount";
  static const String reduceAmountRequiresApproval =
      "You can reduce this amount. If reduced, it will require distributor approval.";
  static const String enterFinalAmount = "Enter final amount";
  static const String reset = "Reset";

  /// Use %s for discount amount, %s for percentage. Message: subsidy requires approval.
  static const String subsidyRequestMessage =
      "Subsidy Request: You are requesting a discount of %s (%s). This order will require distributor approval before it can be assigned for delivery.";

  /// Use %s for max amount (e.g. Rs. 0.00).
  static const String finalAmountCannotExceedCalculated =
      "Final amount cannot be higher than calculated total. Please enter a value less than or equal to %s.";
  static const String total = "Total";
  static const String orderValidatedAgainstCreditLimit =
      "Order will be validated against shop's credit limit before creation.";
  static const String conditionalOrderOptions = "Conditional Order Options";
  static const String conditionalOrderOptionsHelp =
      "If shop's available credit is less than order amount, you can use one of these options:";
  static const String normalOrderCreditSufficient =
      "Normal Order (Credit must be sufficient)";
  static const String paymentBeforeDelivery = "Payment Before Delivery";
  static const String paymentBeforeDeliveryHelp =
      "Delivery man will collect payment before delivery.";
  static const String instantCreditLimitIncrease =
      "When you record a collection, the shop's outstanding balance will be reduced immediately, allowing them to place orders right away without waiting for distributor approval.";
  static const String impactPreview = "Impact Preview";
  static const String currentOutstanding = "Current Outstanding";
  static const String newOutstanding = "New Outstanding";
  static const String newAvailableCredit = "New Available Credit";
  static const String perfectShopFullCredit =
      "Perfect! Shop will have full credit limit available after this collection.";
  static const String getCurrentLocation = "Get Current Location";
  static const String gpsCaptureHint =
      "Click the button to automatically capture your current GPS coordinates.";
  static const String selectVisitTime = "Select Visit Time";
  static const String leaveEmptyCurrentTime =
      "Leave empty to use current time.";
  static const String tapToCaptureCurrentTime = "Tap to capture current time";
  static const String selectMultipleVisitTypesHint =
      "You can select multiple visit types. If you select 'Order Booking' or 'Daily Collections', additional forms will appear.";
  static const String photoOptional = "Photo";
  static const String uploadPhotoProofVisit =
      "Upload a photo as proof of visit.";
  static const String reasonForVisit = "Reason for visit or additional notes";
  static const String registerVisitButton = "Register Visit";
  static const String collectionDetails = "Collection Details";
  static const String notesAboutCollection = "Notes about this collection";

  // Day names (for visit register shop dropdown)
  static const String dayMonday = "Monday";
  static const String dayTuesday = "Tuesday";
  static const String dayWednesday = "Wednesday";
  static const String dayThursday = "Thursday";
  static const String dayFriday = "Friday";
  static const String daySaturday = "Saturday";
  static const String daySunday = "Sunday";
  static const String dayMon = "Mon";
  static const String dayTue = "Tue";
  static const String dayWed = "Wed";
  static const String dayThu = "Thu";
  static const String dayFri = "Fri";
  static const String daySat = "Sat";
  static const String daySun = "Sun";

  /// Fallback for date/time when not set (e.g. formatter).
  static const String dateTimeUnset = "–";
  static const String periodAm = "AM";
  static const String periodPm = "PM";
  static const String validationFailed = "Validation failed";
  static const String requestFailedTryAgain =
      "Request failed. Please try again.";
  static const String somethingWentWrongTryAgain =
      "Something went wrong. Please try again.";

  // Delivery man – pickup / deliver / return
  static const String selectWarehouse = "Select warehouse";
  static const String pickupQuantities = "Pickup quantities";
  static const String createDeliveryAndContinue = "Create delivery & continue";
  static const String confirmPickup = "Confirm pickup";
  static const String deliveryQuantities = "Delivery quantities";
  static const String confirmDelivery = "Confirm delivery";
  static const String returnQuantities = "Return quantities";
  static const String returnReasonLabel = "Return reason";
  static const String returnReasonHint = "Why are you returning this stock?";
  static const String confirmReturn = "Confirm return";
  static const String pleaseEnterReturnReason = "Please enter return reason";
  static const String orderBookerLabel = "Order Booker";
  static const String subsidyLabel = "Subsidy";
  static const String deliverySectionTitle = "Delivery";
  static const String pickupAtLabel = "Pickup";
  static const String deliveredAtLabel = "Delivered at";
  static const String returnedAtLabel = "Returned at";
  static const String startDeliveryPickupLabel =
      "Start delivery (Pickup from warehouse)";
  static const String verifyAndMarkOrderLabel =
      "Verify & mark order delivered/cancelled";
  static const String verifyAndCompleteOrderTitle = "Verify & complete order";
  static const String deliveryStatusLabel = "Delivery status";
  static const String deliveredStatusOption = "Delivered";
  static const String cancelledStatusOption = "Cancelled";
  static const String filterAll = "All";
  static const String noDeliveriesMatchFilter = "No deliveries match filter";
  static const String productFallbackLabel = "Product";
  static const String warehouseFallbackLabel = "Warehouse";

  // Deliveries tab section headers
  static const String dmSectionConfirmed = "Confirmed";
  static const String dmSectionDeliveredAndReturned = "Delivered & Returned";
  static const String dmSectionCancelled = "Cancelled";

  // Delivery status chips (for order card)
  static const String dmStatusNotStarted = "Not Started";
  static const String dmStatusPendingPickup = "Pending Pickup";
  static const String dmStatusPickedUp = "Picked Up";
  static const String dmStatusInTransit = "In Transit";
  static const String dmStatusDelivered = "Delivered";
  static const String dmStatusPartiallyDelivered = "Partially Delivered";
  static const String dmStatusReturned = "Returned";
  static const String dmStatusFailed = "Failed";

  // Order detail actions (by delivery status)
  static const String onboardStockLabel = "Onboard stock";
  static const String dailyCollectionLabel = "Daily collection";
  static const String updateDeliveryLabel = "Update delivery";
  static const String returnRemainingStockLabel = "Return remaining stock";
  static const String viewDetailsLabel = "View details";
  static const String orderFullyDeliveredMessage = "Order is fully delivered.";
  static const String paymentBeforeDeliveryTag = "Payment before delivery";
  static const String recordDailyCollectionFirst =
      "Record daily collection first before delivering.";
  static const String recordDailyCollectionFromDashboard =
      "Open Dashboard to record daily collection.";

  // Delivery detail screen
  static const String completeDeliveryTimeline = "Complete Delivery Timeline";
  static const String deliveryItemsDetails = "Delivery Items Details";
  static const String deliveredDate = "Delivered Date";
  static const String subsidyAndDiscountInfo = "Subsidy & Discount Information";
  static const String discountAmount = "Discount Amount";
  static const String approvedAt = "Approved At";
  static const String originalAmount = "Original";
  static const String afterDiscount = "After Discount";
  static const String itemColumn = "Item";
  static const String pickedColumn = "Picked";
  static const String pickedUpLabel = "Picked Up";
  static const String deliveredColumn = "Delivered";
  static const String alreadyDeliveredLabel = "Already delivered";
  static const String returnedColumn = "Returned";
  static const String availableToReturnLabel = "Available to Return";
  static const String itemsToReturnTitle = "Items to Return";
  static const String noTimelineEvents = "No timeline events recorded";
  static const String noDeliveryItemsRecorded = "No delivery items recorded.";
  static const String noOrderItemsRecorded = "No order items in this order.";
  // Deliver / Pickup form section labels
  static const String orderItemsSection = "Order Items";
  static const String orderedQty = "Ordered Qty";
  static const String availableInWarehouse = "Available in Warehouse";
  static const String deliverQty = "Deliver Quantity";
  static const String productNotAvailableInWarehouse =
      "Product not available in this warehouse.";
  static const String pickupNoteSelectWarehouseFirst =
      "Note: Select a warehouse first to see available inventory. Pickup quantities cannot exceed available stock.";
  static const String gpsLocationOptional = "GPS Location (Optional)";
  static const String getLocation = "Get Location";
  static const String latitudePlaceholder = "e.g., 33.6844";
  static const String longitudePlaceholder = "e.g., 73.0479";
  static const String deliveryProofImagesOptional =
      "Delivery Proof Images (Optional)";
  static const String chooseFiles = "Choose files";
  static const String noFileChosen = "No file chosen";
  static const String deliveryRemarksOptional = "Delivery Remarks (Optional)";
  static const String addNotesAboutDelivery =
      "Add any notes about the delivery...";
  // Daily Collection dialog
  static const String collectionAmountRs = "Collection Amount (Rs.)";
  static const String addNotesAboutCollection =
      "Add any notes about the collection...";
}
