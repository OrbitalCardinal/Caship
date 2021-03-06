# Caship

Caship is an application that helps people lending money to other people without any worries about managing times or interests. This application gives you the option of using paypal as the transaction service. It is meant to be used between users saved contacts.

## Task List
This project will be managed with the Agile method, each week some advancements will be presented. At the same time this planning can be used as a task list for the developers to follow.

### Week 1
- Log in 
    - Registered email.
    - Password.
    - Forgot password.
    - Have an account? Sign Up.
- Sign Up
  - Full name
  - Country
  - Phone number
  - Birth date
  - Email
  - Password
  - Confirm password
    - Eight characters minimum
    - One uppercase letter
    - One number
  - Agree with terms and conditions
- Terms and conditions page.
- Email Authentication and confirmation.
  - Before log in.
  - Confirm email validation
- Log out

|  Lending       |
| ---------      |
| id             |
| requestDate    |
| acceptanceDate |
| timeLimit      |
| amount         |
| requesterId    |
| lenderId       |
| details        |
| delay          |
| status         |

Minimum 50 

Account suspension 3 delays
Function after passed timeLimit to send a strike to de user with delay

### Week 2
- Log out 
- In App navigation (UI screens)
  - Contacts in app list (Screen)
    - The ones that are registered with the same phone number.
  - Personal profile (Tab bar - Screen)
    - Profile picture
    - Information
      - Update or add information
        - Name
        - Phone number
        - Country
        - Ocupation
  - History (Tab bar - Screen)
    - Show recent transactions (Ordered by date)
      - Date
      - Amount
      - Person
  - Contact screen lend money (Screen)
    - Favorite option
    - Ask for money
      - Amount
      - Details (Motivation)
  - Payment screen (Screen)
    - Paypal web view
    - Other payment gateways
  - Notifications (Tab bar - Screen)
    - Pending transactions
    - accept or decline
    - See transaction
      - Person who asks
      - Amount
      - Emitted date
      - Interests yes or no
      - Time to pay back
  - Settings (Tab bar - Screen)
