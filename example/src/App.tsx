/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import {
  StyleSheet,
  View,
  Text,
  TouchableOpacity,
  Platform,
} from 'react-native';
import { CrispChatSDK, CrispChatUI } from 'react-native-crisp-chat-sdk';

export default function App() {
  const [showChat, setShowChat] = React.useState<boolean>(false);

  React.useEffect(() => {
    CrispChatSDK.setUserEmail('test@test.com');
  }, []);

  const onShowChat = () => {
    if (Platform.OS === 'ios') {
      console.log('hit');
      CrispChatSDK.show();
    } else {
      setShowChat(!showChat);
    }
  };

  return (
    <View style={styles.container}>
      <TouchableOpacity onPress={onShowChat}>
        <Text>{showChat ? 'Hide' : 'Show'} Chat</Text>
      </TouchableOpacity>
      {showChat && <CrispChatUI style={{ flex: 1, width: '100%' }} />}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
