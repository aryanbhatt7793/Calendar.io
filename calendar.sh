#!/bin/bash

# File to store events
EVENTS_FILE="events.txt"

# Function to show the current month's calendar
show_calendar() {
	clear
	cal "$1" "$2"  # Displays the calendar for the given month and year
}

# Function to show the current date
show_current_date() {
	clear
	echo "Today's date is: $(date "+%A, %B %d, %Y")"
}

# Function to add an event
add_event() {
	clear
	read -p "Enter the date for the event (YYYY-MM-DD): " event_date
	read -p "Enter event description: " event_desc
	echo "$event_date: $event_desc" >> $EVENTS_FILE
	echo "Event added successfully."
}

# Function to view events on a specific day
view_events() {
	clear
	read -p "Enter the date to view events (YYYY-MM-DD): " view_date
	echo "Events on $view_date:"
	grep "^$view_date" $EVENTS_FILE || echo "No events for this date."
}

# Function to view the day of the week for a specific date
view_day_of_week() {
	clear
	read -p "Enter the date (YYYY-MM-DD): " date_input
	day_of_week=$(date -d "$date_input" "+%A")
	echo "The day of the week for $date_input is: $day_of_week"
}

# Function to clear all events
clear_events() {
	clear
	echo "Are you sure you want to delete all events? (y/n)"
	read confirmation
	if [[ $confirmation == "y" || $confirmation == "Y" ]]; then
    	> $EVENTS_FILE  # Empty the events file
    	echo "All events have been cleared."
	else
    	echo "No events were deleted."
	fi
}

# Main program loop
while true; do
	clear
	echo "==============================="
	echo "   Simple Terminal Calendar	"
	echo "==============================="
	echo "1. Show the current month's calendar"
	echo "2. View a specific month"
	echo "3. Show today's date"
	echo "4. Add an event"
	echo "5. View events for a specific day"
	echo "6. View the day of the week for a specific date"
	echo "7. Clear all events"
	echo "8. Exit"
	echo "==============================="
	read -p "Select an option (1-8): " choice

	case $choice in
    	1)
        	show_calendar $(date +%m) $(date +%Y)
        	;;
    	2)
        	read -p "Enter month (1-12): " month
        	read -p "Enter year (YYYY): " year
        	show_calendar $month $year
        	;;
    	3)
        	show_current_date
        	;;
    	4)
        	add_event
        	;;
    	5)
        	view_events
        	;;
    	6)
        	view_day_of_week
        	;;
    	7)
        	clear_events
        	;;
    	8)
        	echo "Exiting the calendar..."
        	break
        	;;
    	*)
        	echo "Invalid option. Please try again."
        	;;
	esac

	# Pause to allow user to view the calendar
	read -p "Press Enter to continue..." dummy
done
