<?php

include "../config/conn.php";

$method = $_SERVER['REQUEST_METHOD'];
$result = [];

if ($method == 'POST') {
    $json = file_get_contents('php://input');
    $obj = json_decode($json, true);

    // Log the received data
    error_log(print_r($obj, true));

    // Check if the JSON is correctly parsed
    if ($obj === null) {
        error_log("JSON parsing error: " . json_last_error_msg());
    }

    // Define the required fields
    $fields = ['id', 'name', 'age', 'phone_no', 'location', 'emailid'];
    $missing_fields = [];
    
    // Check for missing fields
    foreach ($fields as $field) {
        if (!isset($obj[$field])) {
            $missing_fields[] = $field;
        }
    }

    // Log any missing fields
    if (!empty($missing_fields)) {
        error_log("Missing fields: " . implode(", ", $missing_fields));
        echo json_encode(["status" => false, "msg" => "Required fields are missing: " . implode(", ", $missing_fields)]);
        exit;
    }

    // Process the data
    $id = mysqli_real_escape_string($conn, $obj['id']);
    $name = mysqli_real_escape_string($conn, $obj['name']);
    $email = mysqli_real_escape_string($conn, $obj['emailid']);
    $age = mysqli_real_escape_string($conn, $obj['age']);
    $location = mysqli_real_escape_string($conn, $obj['location']);
    $phone_no = mysqli_real_escape_string($conn, $obj['phone_no']);

    
      if( isset($obj['base64Image'])){
            $base64Image = $obj['base64Image'];

            // Check if base64Image is set and not empty
            if (!empty($base64Image)) {
                // Decode the base64 data
                $imageData = base64_decode($base64Image);

                // Get image info
                $imageInfo = getimagesizefromstring($imageData);
                if ($imageInfo === false) {
                    echo json_encode(["status" => false, "msg" => "Invalid image data"]);
                    exit;
                }

                // Determine MIME type and generate filename
                $mimeType = $imageInfo['mime'];
                $number = rand(100, 100000);
                $generateFilename = (string)$number . $name . $phone_no;
                $filenames = '';

                // Determine file extension based on MIME type
                switch ($mimeType) {
                    case 'image/jpeg':
                        $filenames = $generateFilename . ".jpeg";
                        break;
                    case 'image/png':
                        $filenames = $generateFilename . ".png";
                        break;
                    case 'image/jpg':
                        $filenames = $generateFilename . ".jpg";
                        break;
                    default:
                        echo json_encode(["status" => false, "msg" => "Unknown image format"]);
                        exit;
                }

                // Define the file path where the image will be saved
                $filePath = "../uploads/patient_image/" . $filenames;

                // Save the image file
                if (file_put_contents($filePath, $imageData) === false) {
                    echo json_encode(["status" => false, "msg" => "Failed to save image"]);
                    exit;
                }
            } else {
                // Handle case where base64Image is not set or empty
                $filePath = '../uploads/doctors_image/default.jpg';
            }

            // Prepare SQL statement (consider using prepared statements to prevent SQL injection)
            $sql = "UPDATE doctors_detials SET doctor_name = ?, age = ?, location = ?, email_id = ?, phone_no = ?, image_path = ? WHERE id = ?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("sssssss", $name, $age, $location, $email, $phone_no, $filePath, $id);
      }else{
          $sql = "UPDATE doctors_detials SET doctor_name = ?, age = ?, location = ?, email_id = ?, phone_no = ? WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssssss", $name, $age, $location, $email, $phone_no, $id);
          
      }

    // Execute SQL statement
    if ($stmt->execute()) {
        $result['status'] = true;
        $result['msg'] = 'Profile updated successfully';
    } else {
        $result['status'] = false;
        $result['msg'] = 'Failed to update profile';
    }

    $stmt->close();
    echo json_encode($result);
} else {
    echo json_encode(["status" => false, "msg" => "Invalid request method"]);
}

?>
