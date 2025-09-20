# Photo Uploader (Flutter + BLoC)

A prototype photo uploader app for selecting images from the gallery and uploading them to a server.  
Built with **Flutter** and **BLoC (Cubit)** for state management.

---

## Features
- Select up to **5 photos** from the device gallery.
- Sequential upload: photos are uploaded **one by one**.
- Progress indicator (e.g., `2 of 5 photo is uploading...`).
- Each photo has a status:
  - `pending` — waiting to be uploaded
  - `loading` — currently uploading
  - `success` — uploaded successfully
  - `error` — upload failed
- Retry failed uploads only, without restarting the entire queue.
- Upload works **only while the app is active** (no background services required).

---

## How to Run

### 1. Clone the repository
```bash
git clone https://github.com/glabglob/rockwolf_test.git

cd rockwolf_test

``` 

### 2. Install dependencies
```bash
flutter pub get

``` 

### 3. Run the app
```bash
flutter run

``` 

