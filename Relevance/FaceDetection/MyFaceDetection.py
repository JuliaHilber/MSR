import sys
import dlib
from skimage import io
import xml.etree.ElementTree

# Create a HOG face detector using the built-in dlib class
face_detector = dlib.get_frontal_face_detector()

# Create some count variables
#pictures = 0
#faces_detected = 0

# Create a global location variable
location = ""

# Create a global variable for the file
f = file('face_detection_result.txt', 'w')

# Read the xml file to find out the locations
a = xml.etree.ElementTree.parse("/Volumes/My Passport for Mac/div-2014/devset/devset_topics.xml").getroot()
for topic in a.findall('topic'):
    # Get the location
    location = topic.find('title').text
    # A count variable
    #faces_detected_location = 0
    # Read the xml file to go over all photos of the location
    e = xml.etree.ElementTree.parse("/Volumes/My Passport for Mac/div-2014/devset/xml/" + location + ".xml").getroot()
    for photo in e.findall('photo'):
        #pictures += 1
        # Figure out the path and file name of the picture
        file_name = "/Volumes/My Passport for Mac/div-2014/devset/img/" + location + "/" + photo.get('id') + ".jpg"
        # Load the image into an array
        image = io.imread(file_name)
        # Run the HOG face detector on the image data.
        # The result will be the bounding boxes of the faces in our image.
        detected_faces = face_detector(image, 1)
        # Check if faces were detected
        face_detected = 0
        if len(detected_faces) > 0:
            #faces_detected_location += 1
            face_detected = 1
        # Write in the file if that picture contains faces
        f.write(str(location) + "\t" + str(photo.get('id')) + "\t" + str(face_detected) + "\n")

    # Some prints and increasing counter variables
    #print("Location: " + location + " Number of pictures with faces: " + str(faces_detected_location))
    #faces_detected += faces_detected_location

#print("We can reduce our dataset by " + str(faces_detected*100/pictures) + "%")
#print("Faces detected: " + str(faces_detected))
#print("Images: " + str(pictures))

# Close the file
f.close()
